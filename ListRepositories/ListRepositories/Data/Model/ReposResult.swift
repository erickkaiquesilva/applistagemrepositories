//
//  ReposResult.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

struct List: Codable {
    let total_count: Int
    let items: [Repositore]
}

struct Repositore: Codable {
    let full_name: String
    let stargazers_count: Int
    let owner: User
}

struct User: Codable {
    let login: String
    let avatar_url: String
}
