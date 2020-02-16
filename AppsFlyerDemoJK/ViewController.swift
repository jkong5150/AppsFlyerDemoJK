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
    

    @IBAction func LogInTapped(_ sender: Any) {
        print("Login tapped")
        navigateToDashHome()
        
    }
    
    private func navigateToDashHome(){
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        guard let dashHomeVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardHomeViewController") as? DashboardHomeViewController else {return }
        present(dashHomeVC, animated: true, completion: nil)
    }


}

