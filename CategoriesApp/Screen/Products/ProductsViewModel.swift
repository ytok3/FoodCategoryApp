//
//  ProductsViewModel.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import Foundation

protocol ProductsViewModelOutput {
    func selectCategory(products: [Products])
}

protocol ProductsViewModelProtocol {
    
    var output: ProductsViewModelOutput? {get set}
    var filterId: String? {get set}
    func fetchProducts(id: String?, filter: String?)
}

class ProductsViewModel: ProductsViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceManagerProtocol?
    var output: ProductsViewModelOutput?
    var filterId: String?
    private let categoryId: String?
    private let filter: String?
    
    // MARK: Init
    
    init(service: ServiceManagerProtocol,
         categoryId: String?,
         filter: String?) {
        self.service = service
        self.categoryId = categoryId
        self.filter = filter
        
        self.filterId = categoryId
        
        fetchProducts(id: categoryId, filter: filter)
    }
    
    // MARK: Func
    
    func fetchProducts(id: String?, filter: String?) {
        service?.fetch(url: Constants.generateProductsURL(with: id, filter: filter)!, completion: { (response: Result<ProductsList, Error>) in
            switch response {
            case .success(let productList):
                self.output?.selectCategory(products: productList.data ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
