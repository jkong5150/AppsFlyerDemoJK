//
//  SignUpViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 5/5/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController : UIViewController {
    
    static let identifier = "SignUpViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backToLoginTapped(_ sender: Any) {
        //set logged in flag to false
        let userDefaults = UserDefaults.standard
        userDefaults.set(false,forKey: "isLoggedIn")
        userDefaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
}
