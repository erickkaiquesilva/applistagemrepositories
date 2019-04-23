//
//  RepositoresLocalTableViewController.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 22/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit
import CoreData

class RepositoresLocalTableViewController: UITableViewController {
    
    
    var label = UILabel()
    
    var fechedResultsController: NSFetchedResultsController<Repositores>!
    
    var repositoresRequest: Repositore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "OPS!!! Nao encontramos nada"
        label.textAlignment = .center
        loadRepositores()
    }

    func loadRepositores(){
        let fetchRequest: NSFetchRequest<Repositores> = Repositores.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "fullName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        
        fechedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fechedResultsController.delegate = self
        
        do {
            try fechedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        let resultCollectionLocal = fechedResultsController.fetchedObjects?.map { (elementOfCollection) -> Int in
            
            let id = elementOfCollection.idUser
            
            return Int(id)
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fechedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoresLocalTableViewCell
        
        guard let repositore = fechedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: repositore)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }

}

extension RepositoresLocalTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            break
        default:
            tableView.reloadData()
        }
    }
}
