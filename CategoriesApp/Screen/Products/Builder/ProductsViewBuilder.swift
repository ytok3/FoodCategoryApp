//
//  ProductsViewBuilder.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import Foundation
import UIKit
import Alamofire

enum ProductsViewBuilder {
    static func build(categoryId: String?, filter: String?) -> UIViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let productsViewModel = ProductsViewModel(service: service,
                                                  categoryId: categoryId,
                                                  filter: filter)
        let productsCollectionView = ProductsCollectionViewProperties()
        let vc = ProductsViewController(viewModel: productsViewModel,
                                        productsCollectionViewProperties: productsCollectionView)
        
        return vc
    }
}
