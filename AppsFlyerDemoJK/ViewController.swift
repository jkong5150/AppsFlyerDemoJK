//
//  ViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/15/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //don't go to landscape.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return .portrait
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = _username.text
        let password = _password.text
        login()
    }
    
    private func login(){
        
    }


}

