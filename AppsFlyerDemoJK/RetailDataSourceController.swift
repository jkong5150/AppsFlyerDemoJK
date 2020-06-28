//
//  RetailDataSourceController.swift
//  AppsFlyerDemoJK
//
//  Created by Jeff Kongthong on 6/22/20.
//  Copyright © 2020 AppsFlyer. All rights reserved.
//

import LBTAComponents

class ProductsHeader : DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .blue
    }
}

class ProductsFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
    }
}

class ProductCell: DatasourceCell {

    override var datasourceItem: Any? {
        didSet {
            productNameLabel.text = datasourceItem as? String
        }
    }
    let productNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override func setupViews() {
        super.setupViews()
        addSubview(productNameLabel)
        productNameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        backgroundColor = .yellow
    }
}

class RetailDataSource: Datasource {
    let products = ["user1","user2","user3"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ProductsHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [ProductsFooter.self]
    }
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ProductCell.self]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return products.count
    }
    override func item(_ indexPath: IndexPath) -> Any? {
        return products[indexPath.item]
    }
    
}

class RetailDataSourceController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let retailDataSource = RetailDataSource()
        self.datasource = retailDataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}
