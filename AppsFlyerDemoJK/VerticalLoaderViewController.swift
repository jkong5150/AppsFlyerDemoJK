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
        setNavigateTo()
    }
    //pass deeplink information here.
    private var navigateTo: String?
    
    private func setNavigateTo(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let navTo = appDelegate.navigateTo
        navigateTo = navTo

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        setNavigateTo()
        navigateToPage()
    }
    
// MARK: Vertical View controllers (Retail, Finance, etc.)
    private func navigateToVC() -> UIViewController {
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "FinanceLoginViewController") as? FinanceLoginViewController)!
        return navigateVC
    }
    
    private func naviagateToRetail() -> UIViewController {
        let mainStoryboard = UIStoryboard(name:"Retail",bundle:Bundle.main)
        let navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "RetailViewController") as? RetailViewController)!
        return navigateVC
    }
    
    private func navigateToPage(){
        
        let mainStoryboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        let navigateVC : UIViewController
        let isLoggedIn: Bool = UserDefaults.standard.bool(forKey:"isLoggedIn")
        
        //already logged in.  run this logic
        if (isLoggedIn) {
            switch (navigateTo){
            case "1099":
                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "Dashboard1099ViewController") as? Dashboard1099ViewController)!
            case "promo":
                navigateVC =  (mainStoryboard.instantiateViewController(withIdentifier: "PromotionViewController") as? PromotionViewController)!

            default:
                navigateVC =  navigateToVC()
            }
        } else {
        
        //otherwise go to the correct Story board.
            guard let vertical = UserDefaults.standard.object(forKey: "vertical") as? String  else { return  }
            switch (vertical){
            case Verticals.retail.rawValue:
                navigateVC =  naviagateToRetail()
            case Verticals.finance.rawValue:
                navigateVC =  navigateToVC()
    //        case Verticals.finance.rawValue:
    //            navigateVC =  (storyboard.instantiateViewController(withIdentifier: "PromotionViewController") as? PromotionViewController)!
            default:
                navigateVC =  navigateToVC()
            }
        }
        navigateVC.modalPresentationStyle = .fullScreen
        present(navigateVC, animated: true, completion: nil)
    }
}
