//
//  MyTableViewCell.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 5/3/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit
class FinanceTableViewCell: UITableViewCell {

    static let identifier = "FinanceTableViewCell"
    static func nib()->UINib{
        return UINib(nibName: "FinanceTableViewCell", bundle: nil)
    }
    @IBOutlet var accountName: UILabel!
    @IBOutlet var accountBalance: UILabel!
    @IBOutlet var accountNumber: UILabel!
    var acct : AccountModel!


    public func configure(with name: String, balance: String, acctNumber: String) {
        accountName.text = name
        accountBalance.text = balance
        accountNumber.text = acctNumber
    }
    
    public func configure(account: AccountModel) {
        acct = account
        accountName.text = account.accountName
        accountBalance.text = account.acccountBalance
        accountNumber.text = account.accountNumber
        if (isCreditCard()){
            self.accountBalance.textColor = .darkGray
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //resize to fit sell
        accountName.contentMode = .scaleAspectFit
        accountNumber.contentMode = .scaleAspectFit
        accountBalance.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func isCreditCard() -> Bool {
        return (acct.accountType == "CreditCard")
        
    }
}
