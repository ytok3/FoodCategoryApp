//
//  DetailViewModel.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 11.09.2022.
//

import Foundation

protocol DetailViewModelOutput {
    
    func selectProduct(product: Detail?)
}

protocol DetailViewModelProtocol {
    
    var output: DetailViewModelOutput? {get set}
}

class DetailViewModel: DetailViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceManagerProtocol?
    var output: DetailViewModelOutput?
    private let productId: String?
    
    // MARK: Init
    
    init(service: ServiceManagerProtocol,
         productId: String?) {
        self.service = service
        self.productId = productId
        
        fetchProductDetail(id: productId)
    }
    
    //MARK: Func
    
    func fetchProductDetail(id: String?) {
        service?.fetch(url: Constants.generateProductDetailURL(with: id)!, completion: { (response: Result<ProductDetail, Error>) in
            switch response {
            case .success(let productDetail):
                self.output?.selectProduct(product: productDetail.data)
            case .failure:
                print("error")
            }
        })
    }
}
