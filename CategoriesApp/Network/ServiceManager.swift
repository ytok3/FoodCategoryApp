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
            "Api-Key": "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=",
            "Alias-Key": "AtS1aPFxlIdVLth6ee2SEETlRxk=",
            "Accept-Language": "en-US,en;q=0.5"
        ]
        
        afSession.request(url, method: .get, headers: headers).validate().responseDecodable(of: T.self) { categori in
            
            if categori.response?.statusCode == 400 {
                return completion(.failure(HttpError.badRequest))
            }
            
            guard let model = categori.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            
            completion(.success(model))
        }
    }
}
