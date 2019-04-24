//
//  RepositoresManager.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 22/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import CoreData

class RepositoresManager{
    static let shared = RepositoresManager()
    var repositores: [Repositores] = []
    
    func loadRepositores(with context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<Repositores>  = Repositores.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            repositores = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteRepositore(index: Int, context: NSManagedObjectContext){
        
        let repositore = repositores[index]
        context.delete(repositore)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init(){
        
    }
}
