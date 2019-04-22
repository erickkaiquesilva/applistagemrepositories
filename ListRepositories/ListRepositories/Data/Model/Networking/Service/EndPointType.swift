//
//  EndPointType.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

protocol EndPointType {
    var base: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}

extension EndPointType {
    var components: URLComponents {
        if var components = URLComponents(string: base){
            components.path = path
            components.queryItems = query
            print(components)
            return components
        }
        fatalError("Fail to set components")
    }
    
    var request: URLRequest {
        if let url = components.url{
            return URLRequest(url: url)
        }
        fatalError("Failed to set URL!")
    }
}
