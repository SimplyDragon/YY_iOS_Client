//
//  Session.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 01/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class Session {
    
    static let instance = Session()
    private init() {}
    
    var token: String = ""
    var userID: Int = 0
    
}
