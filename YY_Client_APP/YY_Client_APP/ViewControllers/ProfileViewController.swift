//
//  ProfileViewController.swift
//  YY_Client_APP
//
//  Created by Ярослав Ясинский on 10/07/2019.
//  Copyright © 2019 Ярослав Ясинский. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {

    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var DateOfBirth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vkService = VKService()
        let userDefaults = UserDefaults.standard
        
        
        AF.request(vkService.getProfile()!).responseJSON { response in
            do {
                let profile = try JSONDecoder().decode(ProfileResponse.self, from: response.data!)
                
                //print(response)
                print(profile)
                
                //Запись и чтение из UserDefaults
                userDefaults.set(profile.response.first_name, forKey: "first_name")
                let firstNameUD = userDefaults.string(forKey: "first_name")
                self.FirstNameLabel.text = "\(String(firstNameUD ?? "Not valid"))"
                
                userDefaults.set(profile.response.last_name, forKey: "last_name")
                self.LastNameLabel.text = "\(profile.response.last_name)"
                
                userDefaults.set(profile.response.bdate, forKey: "bdate")
                self.DateOfBirth.text = "\(profile.response.bdate)"
            } catch {
                print(error) }
        }
        // Получение токена из KeyChain просто для проверки
        print(KeychainWrapper.standard.string(forKey: "tokenKC") ?? "none")
    }
    
    

}
