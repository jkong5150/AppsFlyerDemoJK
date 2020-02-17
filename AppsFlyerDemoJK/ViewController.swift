//
//  ViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/15/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if isLoggedIn {
            navigateToDashHome()
        }
    }
    //don't go to landscape.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return .portrait
        }
    }
    

    @IBAction func LogInTapped(_ sender: Any) {
        print("Login tapped")
        validateLogin()
        
    }
    
    private func validateLogin(){
        //validateFields()
        
        guard let username = usernameTextField.text else {
            //show("Please enter a username.")
            return
        }
        //
        guard let password = passwordTextField.text else {
            //show("Please enter a password.")
            return
        }
        
        let usernamedb = UserDefaults.standard.object(forKey: "username")
        let passworddb = UserDefaults.standard.object(forKey: "password")
        
        if (username == usernamedb as? String && password == passworddb as? String) {
            //save the isLoggedIn flag to true
            navigateToDashHome()
        }
            
    }
    
    private func navigateToDashHome(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "isLoggedIn")
        userDefaults.synchronize()
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        guard let dashHomeVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardHomeViewController") as? DashboardHomeViewController else {return }
        present(dashHomeVC, animated: true, completion: nil)
    }
}

