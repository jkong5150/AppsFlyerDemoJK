//
//  FinanceMyAccountViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 5/3/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import Foundation
import UIKit
class FinanceMyAccountViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    static let AFFinanceMyAccounts: String =  "My Accounts"
    static let AFListToDetail: String =  "ListToDetail"

    @IBOutlet var table: UITableView!
    
    var accounts : [AccountModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(FinanceTableViewCell.nib(), forCellReuseIdentifier: FinanceTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        accounts = createAccounts()
        
        self.title = "Accounts"
    }
    
    private func addTapped(){
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.identifier, for: indexPath) as! FinanceTableViewCell
        //customCell.configure(with: "My Checking", balance: "$2,345.67", acctNumber: "...2345")
        let acct = accounts[indexPath.row]
        //customCell.configure(with: account.accountName, balance: account.acccountBalance, acctNumber: account.accountNumber)
        customCell.configure(account: acct)
        return customCell
    
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Hello World"
//
//        let mySwitch = UISwitch()
//        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_:)) , for: .valueChanged)
//        cell.accessoryView = mySwitch
//
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FinanceMyAccountViewController.AFFinanceMyAccounts
    }
    
    
//    @objc func didChangeSwitch(_ sender: UISwitch) {
//        if sender.isOn {
//            print("User turned it on")
//
//        } else {
//            print("User turned it off")
//        }
//    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let acct = accounts[indexPath.row]
        performSegue(withIdentifier: FinanceMyAccountViewController.AFListToDetail, sender: acct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == FinanceMyAccountViewController.AFListToDetail) {
            let destVC = segue.destination as! FinanceMyAccountsDetailViewController
            destVC.acct = sender as? AccountModel
        }
    }
    
    private func createAccounts() -> [AccountModel] {
        var accts : [AccountModel] = []
        
        let acct1 = AccountModel(accountName: "My Checking", acccountBalance: "$2,099.91", accountNumber: "123456789", accountType: "Checking")
        let acct2 = AccountModel(accountName: "My Savings", acccountBalance: "$12,123.45", accountNumber: "234567890", accountType: "Savings")
        let acct3 = AccountModel(accountName: "My Brokerage", acccountBalance: "$10,250.91", accountNumber: "345678901", accountType: "Brokerage")
        let acct4 = AccountModel(accountName: "Luke's Savings", acccountBalance: "$4,295.91", accountNumber: "456789012", accountType: "Savings")
        let acct5 = AccountModel(accountName: "My Bank Credit Card", acccountBalance: "$1,111.33", accountNumber: "56789123", accountType: "CreditCard")
        accts.append(acct1)
        accts.append(acct2)
        accts.append(acct3)
        accts.append(acct4)
        accts.append(acct5)
        return accts
    }
}
