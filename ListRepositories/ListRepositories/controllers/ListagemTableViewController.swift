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
    var reposLocal: [Repositores] = []
    var reposRequest: [Repositore] = []
    
    
    let label = UILabel()
    var page = 1;
    var perPage = 30;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textAlignment = .center
        label.text = "Carregando Repositorios..."
        loadRepositoresRequest()
        addRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reposRequest = comparador.comparar(repositoreRequest: reposRequest, repositoreLocal: self.repositoresLocal())
        tableView.reloadData()
    }
    
    func loadRepositoresRequest(){
        loadRepositore.getAllRepositores(page: page, perPage: perPage) { (object) in
            switch object{
            case .success(let model):
                self.reposRequest = self.comparador.comparar(repositoreRequest: model.items, repositoreLocal: self.repositoresLocal())
                print(self.repositoresLocal())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func repositoresLocal() -> [Repositores]{
        
        let repoManager = RepositoresManager.shared
        repoManager.loadRepositores(with: context)
        reposLocal = repoManager.repositores
        
        var repositoreLocal: [Repositores] = []
        
        for itemsLocal in reposLocal{
            repositoreLocal.append(itemsLocal)
        }
        print("--------------- REPO LOCAL ---------------")
        print(repositoreLocal)
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
        let count = reposRequest.count
        tableView.backgroundView = count == 0 ? label : nil

        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoreTableViewCell
        let item = self.reposRequest[row]
        cell.prepare(from: item)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        
        reposRequest[row].isSelected.toggle()

        
        tableView.reloadData()
        
        if reposRequest[row].isSelected == true{
            
            let item = reposRequest[row]
            
            let createRepoLocal = RepoLocal()
            createRepoLocal.RepositoreLocal(repositoreRequest: item)
            tableView.reloadData()
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reposRequest.count - 5 {
            page += 1
            perPage += 30
            
            loadRepositore.getAllRepositores(page: page, perPage: perPage) { (object) in
                switch object{
                case .success(let model):
                    self.reposRequest += self.comparador.comparar(repositoreRequest: model.items, repositoreLocal: self.repositoresLocal())
                    print(self.repositoresLocal())
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        print("----------------------------")
                        print("Page",self.page,"PerPage",self.perPage)
                    }
                    print(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
