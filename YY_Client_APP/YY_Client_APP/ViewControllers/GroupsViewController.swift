//
//  GroupsViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class GroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vkService = VKService()
        //vkService.getFriends()
        
        AF.request(vkService.getMyGroups()!).responseJSON { response in
            //            guard let data = response.value else { return }
            do {
                let users = try JSONDecoder().decode(GroupsResponse.self, from: response.data!)
                
                print(users)
            } catch {
                print(error) }
        }
    }
}
