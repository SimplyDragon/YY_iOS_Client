//
//  SearchGroupsViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import Alamofire

class SearchGroupsViewController: UIViewController {

    @IBOutlet weak var RawLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vkService = VKService()
        
        AF.request(vkService.searchGroups(searchQuery: "Лепра")!).responseJSON { response in
            //            guard let data = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: response.data!)
                
                print(groups)
                self.RawLabel.text = "\(groups)"
            } catch {
                print(error) }
        }
    }
}
