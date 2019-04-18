//
//  RepositoreSession.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

class RepositoreSession: RepositoreSessionProtocol, APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    func getAllRepositores(page: Int, perPage: Int, completion: @escaping (Result<[Repositore]?, APIError>) -> Void) {
        let endPoint = RepositoriesEndPoint.allRepositores(page, perPage)
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue
        
        fetch(with: request, decode: [Repositore].self) { (result) in
            
            switch result{
            case .success(let model):
                print(model)
                break
            case .failure(let error):
                print(error)
                break
                
            }
        }
    }
}
