//
//  LoginViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 5/2/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//
import Foundation
import UIKit

class VerticalLoaderViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        naviagateToRetail()
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginTapped(_ sender: Any) {
        naviagateToRetail()
    }
    
    private func navigateToVC(){
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "DashboardHomeViewController") as? DashboardHomeViewController)!

        present(navigateVC, animated: true, completion: nil)
    }
    
    private func naviagateToRetail() {
        let mainStoryboard = UIStoryboard(name:"Retail",bundle:Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "RetailViewController") as? RetailViewController)!
        navigateVC.modalPresentationStyle = .fullScreen
        present(navigateVC, animated: true, completion: nil)
        

    }
}
