//
//  EndPoint.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

enum RepositoriesEndPoint{
    case allRepositores(Int, Int)
}

extension RepositoriesEndPoint: EndPointType{
    
    var query: [URLQueryItem] {
        
        var queryItens = [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "stars")
        ]
        
        switch self {
        case .allRepositores(let page, let perPage):
             queryItens.append(URLQueryItem(name: "page", value: "\(page)"))
             queryItens.append(URLQueryItem(name: "per_page", value: "\(perPage)"))
        }
        return queryItens
    }
    
    
    var base: String {
        return "https://api.github.com"
    }
    
    var path: String {
        switch self {
        case .allRepositores:
            return "/search/repositories"
        }
    }
    
}
