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
