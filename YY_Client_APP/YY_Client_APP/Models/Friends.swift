//
//  Friends.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation

struct FriendsResponse: Codable {
    let response: FriendsResponseInternal
}

struct FriendsResponseInternal: Codable {
    let items: [Friend]
}

struct Friend: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_100: String
    let online: Int
    let track_code: String
}
