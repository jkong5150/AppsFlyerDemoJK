//
//  FinanceMyAccountsDetailViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 5/3/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import Foundation
import UIKit

class FinanceMyAccountsDetailViewController : UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    var acct : AccountModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        balanceLabel.text = acct?.acccountBalance
        self.title = acct?.accountName
    }
}
