//
//  Dashboard1099ViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 2/17/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit

class DeepLink1ViewController: UIViewController {

    static let identifier = "DeepLink1ViewController"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //set logged in flag to false
        let userDefaults = UserDefaults.standard
        userDefaults.set(false,forKey: "isLoggedIn")
        userDefaults.synchronize()
        self.dismiss(animated: false, completion: nil)
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
