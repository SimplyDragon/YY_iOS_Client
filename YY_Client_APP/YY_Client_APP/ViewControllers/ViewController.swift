//
//  ViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 30/06/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftKeychainWrapper

class ViewController: UIViewController, WKNavigationDelegate {
    
    
    // Аутлет на WebView
    @IBOutlet weak var authorizationView: WKWebView!{
        didSet{
            authorizationView.navigationDelegate = self
        }
    }
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6645716"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        authorizationView.load(request)
    }
    
    // Получение токена и формирование запросов к VK API
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        let session = Session.instance
        //session.token = token!
        
        //Сохранение токена в KeyChain и чтение из него
        KeychainWrapper.standard.set(token!, forKey: "tokenKC")
        session.token = KeychainWrapper.standard.string(forKey: "tokenKC") ?? "none"
        
        //print(session.token)
        
        decisionHandler(.cancel)
    }

}

