//
//  DashboardHomeViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/16/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit

class DashboardHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        //set logged in flag to false
        let userDefaults = UserDefaults.standard
        userDefaults.set(false,forKey: "isLoggedIn")
        userDefaults.synchronize()
        self.dismiss(animated: true, completion: nil)
        clearAD()
    }
    
    private func clearAD(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigateTo = nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
