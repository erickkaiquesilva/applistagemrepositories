//
//  ListagemTableViewController.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 18/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit
import CoreData

class ListagemTableViewController: UITableViewController {
    
    let loadRepositore: RepositoreSessionProtocol = RepositoreSession()
    
    let comparador = Comparador()
    
    var fechedResultController: NSFetchedResultsController<Repositores>!
    
    var listRepositore: [Repositore] = []
    
    var repositores: Repositores!
    
    
    let label = UILabel()
    var page = 1;
    var perPage = 30;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textAlignment = .center
        label.text = "OPS!!! nada encontrado"
        
        loadRepositore.getAllRepositores(page: page, perPage: perPage) { (object) in
            switch object{
            case .success(let model):
                self.listRepositore = self.comparador.comparar(repositoreRequest: model.items, repositoreLocal: self.repositoresLocal())
                print(self.repositoresLocal())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(model)
            case .failure(let error):
                print(error)
            }
        }
        addRefreshControl()
    }
    
    func repositoresLocal() -> [Repositores]{
        
        let fetchRequest: NSFetchRequest<Repositores> = Repositores.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fechedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fechedResultController.delegate = self
        
        do {
            try fechedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        var repositoreLocal: [Repositores] = []
        
        for itemsLocal in fechedResultController!.fetchedObjects!{
            repositoreLocal.append(itemsLocal)
        }
        
        return repositoreLocal
    }
    
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }

    @objc func refreshList(){
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listRepositore.count
        tableView.backgroundView = count == 0 ? label : nil

        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoreTableViewCell
        let item = self.listRepositore[row]
        cell.prepare(from: item)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        
        listRepositore[row].isSelected.toggle()
        tableView.reloadData()
        
        if listRepositore[row].isSelected == true{
            
            if repositores == nil{
                repositores = Repositores(context: context)
            }
            
            let item = listRepositore[row]
            
            repositores.idUser = Int64(item.id)
            repositores.isSelected = item.isSelected
            repositores.fullName = item.fullName
            repositores.login = item.owner.login
            repositores.image = item.owner.avatar_url
    
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ListagemTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            break
        default:
            tableView.reloadData()
        }
    }
}
