//
//  ServiceManager.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import Foundation
import Alamofire

typealias resultClosure<T: Codable> = (Result<T, Error>) -> Void

enum HttpError: Error {
    case badRequest, badURL, errorDecodingData, invalidURL, badResponse
}

protocol ServiceManagerProtocol: AnyObject {
    func fetch<T: Codable>(url: URL, completion: @escaping resultClosure<T>)
}

class ServiceManager: ServiceManagerProtocol {
    
    // MARK: Properties
    
    private var afSession: Session
    
    // MARK: Init
    
    init(afSession: Session) {
        self.afSession = afSession
    }
    
    func fetch<T>(url: URL, completion: @escaping resultClosure<T>) where T : Decodable, T : Encodable {
        
        let headers: HTTPHeaders = [
            Constants.API_KEY: Constants.API_KEY_URL,
            Constants.ALIAS_KEY: Constants.ALIAS_KEY_URL,
            Constants.LANGUAGE: Constants.LANGUAGE_URL
        ]
        
        afSession.request(url, method: .get, headers: headers).validate().responseDecodable(of: T.self) { category in
            
            if category.response?.statusCode == 400 {
                return completion(.failure(HttpError.badRequest))
            }
            
            guard let model = category.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            
            completion(.success(model))
        }
    }
}
