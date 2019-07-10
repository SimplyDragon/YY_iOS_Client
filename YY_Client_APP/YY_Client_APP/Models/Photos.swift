//
//  Photos.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation

struct PhotosResponse: Codable {
    let response: PhotosResponseInternal
}

struct PhotosResponseInternal: Codable {
    let items: [Photo]
}

struct Photo: Codable {
    let id: Int
    let album_id: Int
    let date: Int
    let owner_id: Int
    let post_id: Int
    let sizes: [Size]
}

struct Size: Codable {
    let height: Int
    let width: Int
    let type: String
    let url: String
}

