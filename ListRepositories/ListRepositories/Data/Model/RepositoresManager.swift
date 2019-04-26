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
    
    func getRepositore(with id: Int, context: NSManagedObjectContext) -> Repositore{
        do {
            let fetchRequest : NSFetchRequest<Repositores> = Repositores.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uniqueId == %@", id)
            let fetchedResults = try context.fetch(fetchRequest) as! [Repositores]
            if let repositoreGet = fetchedResults.first {
                repositoreGet
            }
        }
        catch {
            print ("fetch task failed", error)
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
