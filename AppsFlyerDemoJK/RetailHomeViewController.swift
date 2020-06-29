//
//  RetailHomeViewController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 6/28/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import Foundation
import UIKit

class RetailHomeViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    static let identifier = "RetailHomeViewController"
    
    var products : [RetailProduct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RetailProductViewCell.nib(), forCellWithReuseIdentifier: RetailProductViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        products = createProducts()
        self.title = "Products"
        
    }
    
    private func createProducts()->[RetailProduct]{
        var prod : [RetailProduct] = []
        let prod1 = RetailProduct(description: "Lorem ipsum", thumbnail: UIImage(imageLiteralResourceName: "af_icon2"), productImage: UIImage(imageLiteralResourceName: "af_icon2"), productName: "Product 1", rating: 5, price: 199.99)
        let prod2 = RetailProduct(description: "Lorem ipsum2", thumbnail: #imageLiteral(resourceName: "icon_schwab"), productImage: #imageLiteral(resourceName: "icon_schwab"), productName: "Product 2", rating: 3, price: 299.99)
        prod.append(prod1)
        prod.append(prod2)
        return prod
    }
         
}

extension RetailHomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension RetailHomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RetailProductViewCell.identifier, for: indexPath) as! RetailProductViewCell
        
        let prod = products[indexPath.row]
        cell.configure(prod: prod)
        //cell.configure(with:UIImage(named: "af_icon2")!)
        return cell
    }
}
extension RetailHomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width:180, height: 260)
    }
}


