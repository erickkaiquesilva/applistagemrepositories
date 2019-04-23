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
        
//        let idUserRequest = repositoreRequest.map({ $0.id })
//
//        let idUserLocal = repositoreLocal.map { (repositoreLocal) -> Int in
//            Int(repositoreLocal.idUser)
//        }
//
//        for idLocal in idUserLocal{
//            print(idLocal)
//        }
//
//
//
//        print("----------------------------------------")
//
//        for idRequest in idUserRequest{
//            print(idRequest)
//        }
    }
    
}

