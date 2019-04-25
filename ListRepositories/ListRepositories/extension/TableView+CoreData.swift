//
//  TableView+CoreData.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 22/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit
import CoreData

extension UITableViewController{
    
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

extension RepoLocal{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
