//
//  FriendsViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {

    @IBOutlet weak var RawLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vkService = VKService()
        
        AF.request(vkService.getFriends()!).responseJSON { response in
            do {
                let users = try JSONDecoder().decode(FriendsResponse.self, from: response.data!)
                
                print(users)
                self.RawLabel.text = "\(users)"
            } catch {
                print(error) }
        }
    }
}
