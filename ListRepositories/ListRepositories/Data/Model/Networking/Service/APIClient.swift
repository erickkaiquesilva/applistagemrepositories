//
//  APPClient.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    
    
    private func decodingTask<T: Decodable>(data: Data, to type: T.Type) -> T? {
        do {
            let genericModel = try JSONDecoder().decode(T.self, from: data)
            return genericModel
        } catch let err{
            print(err.localizedDescription)
            return nil
        }
        
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailed(description: error?.localizedDescription ?? "No description")))
                return
            }
            guard httpResponse.statusCode == 200  else {
                completion(.failure(APIError.responseUnsuccessful(description: "\(httpResponse.statusCode)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            guard let model = self.decodingTask(data: data, to: decode) else {
                completion(.failure(APIError.jsonConversionFailure(description: "Error Parcial")))
                return
            }
            
            completion(.success(model))
            
        }
        task.resume()
        
    }
    
}
