//
//  DetailViewBuilder.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 11.09.2022.
//

import Foundation
import UIKit
import Alamofire

enum DetailViewBuilder {
    static func build(productId: String?) -> UIViewController {
        let service = ServiceManager(afSession: Alamofire.Session.default)
        let detailViewModel = DetailViewModel(service: service, productId: productId)
        let vc = DetailViewController(viewModel: detailViewModel)
        
        return vc
    }
}
