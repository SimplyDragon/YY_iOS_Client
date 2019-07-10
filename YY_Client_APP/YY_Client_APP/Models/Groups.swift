//
//  Groups.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation

struct GroupsResponse: Codable {
    let response: GroupsResponseInternal
}

struct GroupsResponseInternal: Codable {
    let items: [Group]
}

struct Group: Codable {
    let id: Int
    let name: String
    let photo_50: String
    
}
