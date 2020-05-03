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
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
}
