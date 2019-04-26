//
//  CreateRepoLocal.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 25/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit

protocol Repo {
    func RepositoreLocal(repositoreRequest: Repositore)
}

class RepoLocal: Repo {
    
    var repositoreLocal: Repositores!
    
    func RepositoreLocal(repositoreRequest: Repositore) {
            print(repositoreRequest)
            if repositoreLocal == nil{
                repositoreLocal = Repositores(context: context)
            }
            repositoreLocal.idUser = Int64(repositoreRequest.id)
            repositoreLocal.isSelected = repositoreRequest.isSelected
            repositoreLocal.fullName = repositoreRequest.fullName
            repositoreLocal.login = repositoreRequest.owner.login
            repositoreLocal.image = repositoreRequest.owner.avatar_url
        
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
    }
}
