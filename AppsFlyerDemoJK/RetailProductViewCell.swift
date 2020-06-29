//
//  RetailProductViewCell.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 6/28/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import UIKit

class RetailProductViewCell: UICollectionViewCell {

    static let identifier = "RetailProductViewCell"
    var retailProduct : RetailProduct!

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var productName : UILabel!
    //@IBOutlet var productDescription: UILabel!
    @IBOutlet var price: UILabel!
    //@IBOutlet var rating : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnail.contentMode = .scaleAspectFit
        //productDescription.contentMode = .scaleAspectFit
        productName.contentMode = .scaleAspectFit
        
        
    }
    
//    public func configure(with image: UIImage, productName: String, productDescription: String, price: String, rating: String){
//        self.thumbnail.image = image
//        self.productName.text = productName
//        self.productDescription.text = productDescription
//        self.price.text =  price
//        self.rating.text = rating
//    }

    public func configure(prod: RetailProduct) {
        retailProduct = prod
        thumbnail.image = prod.thumbnail
        //productDescription.text = prod.description
        productName.text = prod.productName
        price.text = "\(prod.price)"
        //rating.text = "\(prod.rating)"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RetailProductViewCell", bundle: nil)
    }
}
