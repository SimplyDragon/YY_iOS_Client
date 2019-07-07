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
        session.token = token!
        
        print(session.token)
        
        doNetworkRequest(token: session.token)
        
        decisionHandler(.cancel)
    }
    
    // Получение данных по группам, друзьям и фото
    // to-do перенести в отдельный файл
    func doNetworkRequest(token: String) {
        
        authorizationView.load(getFriends()!)
        let request = Alamofire.Session.default
        
        // Получаем список друзей
        request.request(getFriends()!).responseJSON { response in
            if let json = response.value {
                print("FRIENDS JSON: \(json)")
            }
        }
        
        // Получаем список фотографий пользователя
        request.request(getPhotos(id: "159295915")!).responseJSON { response in
            if let json = response.value {
                print("PHOTOS JSON: \(json)")
            }
        }

        // Получаем список групп пользователя
        request.request(getMyGroups()!).responseJSON { response in
            if let json = response.value {
                print("GROUPS JSON: \(json)")
            }
        }

        // Получаем список групп по запросу
        request.request(searchGroups(searchQuery: "Лепра")!).responseJSON { response in
            if let json = response.value {
                print("SEARCH JSON: \(json)")
            }
        }
    }
    
    
    // Формировние запросов к VK API
    // to-do Перенести в отдельный класс
    func getFriends() -> URLRequest? {
        let session = Session.instance
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: "nickname,photo_100"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
    
    func getPhotos(id ID: String) -> URLRequest? {
        let session = Session.instance
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: ID),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "rev", value: "0"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
    
    func getMyGroups() -> URLRequest? {
        let session = Session.instance
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "filter", value: "groups"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
    
    func searchGroups(searchQuery query: String) -> URLRequest? {
        let session = Session.instance
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "3"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url {
            return URLRequest(url: url)
        }
        
        return nil
    }

}

