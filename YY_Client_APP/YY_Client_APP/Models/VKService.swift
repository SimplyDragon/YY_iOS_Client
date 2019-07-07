//
//  VKService.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 07/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation
import Alamofire

class VKService {
    
    let vksession = Session.instance
    let token: String
    
    init() {
        self.token = vksession.token
    }
    
    // Формировние запросов к VK API
    // to-do Перенести в отдельный класс
    func getFriends() -> Any? {
        let session = Session.instance
        let request = Alamofire.Session.default
        
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
            request.request(URLRequest(url: url)).responseJSON { response in
                if let json = response.value {
                    print("FRIENDS JSON: \(json)")
                }
            }
            
            return url
        }
        
        return nil
    }
    
    func getPhotos(id ID: String) -> Any? {
        let session = Session.instance
        let request = Alamofire.Session.default
        
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
            request.request(URLRequest(url: url)).responseJSON { response in
                if let json = response.value {
                    print("PHOTOS JSON: \(json)")
                }
            }
            return url
        }
        
        return nil
    }
    
    func getMyGroups() -> Any? {
        let session = Session.instance
        let request = Alamofire.Session.default
        
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
            request.request(URLRequest(url: url)).responseJSON { response in
                if let json = response.value {
                    print("GROUPS JSON: \(json)")
                }
            }
            
            return url
        }
        
        return nil
    }
    
    func searchGroups(searchQuery query: String) -> Any? {
        let session = Session.instance
        let request = Alamofire.Session.default
        
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
            request.request(URLRequest(url: url)).responseJSON { response in
                if let json = response.value {
                    print("SEARCH JSON: \(json)")
                }
            }
            
            return url
        }
        
        return nil
    }
    
    
    // Сервисная функция, чтобы проверить, что все запросы уходят
    // Получение данных по группам, друзьям и фото
    func doNetworkRequest() {
        
        let request = Alamofire.Session.default
        
        // Получаем список друзей
        getFriends()
        
        // Получаем список фотографий пользователя
        getPhotos(id: "159295915")

        // Получаем список групп пользователя
        getMyGroups()
//
//        // Получаем список групп по запросу
        searchGroups(searchQuery: "Лепра")
    }
}
