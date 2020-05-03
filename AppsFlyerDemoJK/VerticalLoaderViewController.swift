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
        
        guard let vertical = UserDefaults.standard.object(forKey: "vertical") as? String  else { return  }
        let navigateVC : UIViewController
        switch (vertical){
        case Verticals.retail.rawValue:
            navigateVC =  naviagateToRetail()
//        case Verticals.finance.rawValue:
//            navigateVC =  (storyboard.instantiateViewController(withIdentifier: "PromotionViewController") as? PromotionViewController)!
        default:
            navigateVC =  navigateToVC()
        }
        navigateVC.modalPresentationStyle = .fullScreen
        present(navigateVC, animated: true, completion: nil)
    }
}
