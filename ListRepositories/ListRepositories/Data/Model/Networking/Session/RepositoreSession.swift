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
    
    
    func getAllRepositores(completion: @escaping (Result<[Repositore]?, APIError>) -> Void) {
        let endPoint = RepositoriesEndPoint.allRepositores(2, 30)
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue
        
        fetch(with: request, decode: [Repositore], completion: <#T##(Result<Decodable, APIError>) -> Void#>)
    }
    
    
    func getAllBeers(completion: @escaping (Result<[BeerElement]?, APIError>) -> Void) {
        let endPoint = BeerEndpoint.allBeers
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue
        
        fetch(with: request, decode: { json -> []? in
            guard let beerResult = json as? [BeerElement] else { return nil }
            return beerResult
        }, completion: completion)
    }
    
}
