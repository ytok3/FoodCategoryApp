//
//  Constant.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import Foundation

struct Constants {
    
    static let BASE_URL = "https://api.shopiroller.com/v2.0/"
    
    static let API_KEY = "Api-Key"
    static let API_KEY_URL = "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I="
    static let ALIAS_KEY  = "Alias-Key"
    static let ALIAS_KEY_URL = "AtS1aPFxlIdVLth6ee2SEETlRxk="
    static let LANGUAGE = "Accept-Language"
    static let LANGUAGE_URL = "en-US,en;q=0.5"
    
    static let CATEGORY = "categories"
    static let PRODUCT = "products/"
    static let FILTER = "advanced-filtered?categoryId="
    static let SORT = "&sort="
    
}

extension Constants {
    static func generateURL() -> URL? {
        URL(string: BASE_URL + CATEGORY)
    }
    
    static func generateProductsURL(with id: String?, filter: String?) -> URL? {
        URL(string: BASE_URL + PRODUCT + FILTER + id! + SORT + filter!)
    }
    
    static func generateProductDetailURL(with id: String?) -> URL? {
        URL(string: BASE_URL + PRODUCT + id!)
    }
}
