//
//  Result.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error{
    case success(T)
    case failure(U)
}
