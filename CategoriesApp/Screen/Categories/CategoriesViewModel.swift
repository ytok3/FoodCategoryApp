//
//  CategoriesViewModel.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import Foundation

protocol CategoriesViewModelOutput {
    func updateData(categories: [Categories])
}

protocol CategoriesViewModelProtocol {
    
    var output: CategoriesViewModelOutput? {get set}
    func fetchCategories()
}

class CategoriesViewModel: CategoriesViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceManagerProtocol?
    var output: CategoriesViewModelOutput?
    
    
    // MARK: Init
    init(service: ServiceManagerProtocol) {
        self.service = service
        
        fetchCategories()
    }
    
    // MARK: Funcs
    
    func fetchCategories() {
        service?.fetch(url: Constants.generateURL()!, completion: { (response: Result<CategoriesList, Error>) in
            switch response {
            case .success(let categoryList):
                self.output?.updateData(categories: categoryList.data ?? [])
            case .failure:
                print("error")
            }
        })
    }
}
