//
//  Comparador.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 23/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import Foundation

class Comparador{
    
    func comparar(repositoreRequest: [Repositore], repositoreLocal: [Repositores]) -> [Repositore]{
        return repositoreRequest.map { (repoResponse) in
            var repoResponse = repoResponse
            for repoLocal in repositoreLocal {
                if Int(repoLocal.idUser) == repoResponse.id {
                    repoResponse.isSelected = true
                    break
                }
            }
            return repoResponse
        }
    }
    
}

