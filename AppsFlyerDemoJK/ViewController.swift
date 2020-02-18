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
    
    //pass deeplink information here.
    private var navigateTo: String?
    
//    private func setNavigateTo(navigateTo: String) {
//        self.navigateTo = navigateTo
//    }
//
//    private func getNavigateTo() -> String? {
//        return navigateTo
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //get the navigate to info.
        
        setNavigateTo()
    }
    
    
    
    private func setNavigateTo(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let navTo = appDelegate.navigateTo
        navigateTo = navTo

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//        if isLoggedIn {
//            navigateToPage()
//        }
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
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "isLoggedIn")
            userDefaults.synchronize()
            navigateToPage()
        }
            
    }
    
    private func navigateToPage(){
        
        //set navigate to because the view could already be active.
        setNavigateTo()

        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC : UIViewController
        switch (navigateTo){
        case "1099":
            navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "Dashboard1099ViewController") as? Dashboard1099ViewController)!
        default:
            navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "DashboardHomeViewController") as? DashboardHomeViewController)!
        }
        
        present(navigateVC, animated: true, completion: nil)
    }
}

