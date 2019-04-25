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
    
    lazy var label = UILabel()
    var repos: [Repositores] = []
    
    let reposManager = RepositoresManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "OPS!!! Nao existe lista de Favoritos ainda"
        label.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadRepositores()
        tableView.reloadData()
    }
    
    func loadRepositores(){
        reposManager.loadRepositores(with: context)
        repos = reposManager.repositores
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = repos.count
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoresLocalTableViewCell
        cell.prepare(with: repos[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            repos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            let repositorieDelete = repos[indexPath.row]
            
            context.delete(repositorieDelete)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
