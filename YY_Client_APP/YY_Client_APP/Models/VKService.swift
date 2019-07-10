//
//  VKService.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 07/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKService {
    
    let vksession = Session.instance
    let token: String
    
    init() {
        self.token = vksession.token
    }
    
    // Формировние запросов к VK API
    func getProfile() -> URLConvertible? {
        let session = Session.instance
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/account.getProfileInfo"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url {
            return url
        }
        
        return nil
    }
    
    func getFriends() -> URLConvertible? {
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
            return url
        }
        
        return nil
    }
    
    func getPhotos(id ID: String) -> URLConvertible? {
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
            return url
        }
        
        return nil
    }
    
    func getMyGroups() -> URLConvertible? {
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
            return url
        }
        
        return nil
    }
    
    func searchGroups(searchQuery query: String) -> URLConvertible? {
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
            return url
        }
        
        return nil
    }
}
