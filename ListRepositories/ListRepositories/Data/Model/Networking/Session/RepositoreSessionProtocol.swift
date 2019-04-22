//
//  RepositoreSessionProtocol.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

protocol RepositoreSessionProtocol {
    func getAllRepositores(page: Int, perPage: Int, completion: @escaping (Result<List, APIError>) -> Void)
}
