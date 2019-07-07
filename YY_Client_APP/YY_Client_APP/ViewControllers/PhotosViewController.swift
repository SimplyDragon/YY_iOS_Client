//
//  PhotosViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 08/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import Alamofire

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vkService = VKService()
        
        AF.request(vkService.getPhotos(id: "159295915")!).responseJSON { response in
            do {
                let users = try JSONDecoder().decode(PhotosResponse.self, from: response.data!)
                
                print(users)
            } catch {
                print(error) }
        }
    }
}
