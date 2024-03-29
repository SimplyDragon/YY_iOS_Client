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

    @IBOutlet weak var GroupsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vkService = VKService()
        
        AF.request(vkService.getMyGroups()!).responseJSON { response in
            //            guard let data = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: response.data!)
                
                print(groups)
                self.GroupsLabel.text = "\(groups)"
            } catch {
                print(error) }
        }
    }
}
