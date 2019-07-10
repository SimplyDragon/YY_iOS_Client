//
//  Profile.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 10/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable {
    let response: Profile
}

struct Profile: Codable {
    let first_name: String
    let last_name: String
    let bdate: String    
}
