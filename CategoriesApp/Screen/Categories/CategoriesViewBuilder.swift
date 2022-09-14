//
//  CategoriesViewBuilder.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import Foundation
import UIKit
import Alamofire

enum CategoriesViewBuilder {
    static func build() -> UIViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let viewModel = CategoriesViewModel(service: service)
        let categoriesCollectionView = CategoriesCollectionViewProperties()
        let vc = CategoriesViewController(viewModel: viewModel, collectionViewProperties: categoriesCollectionView)
        
        return  vc
    }
}
