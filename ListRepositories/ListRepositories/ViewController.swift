//
//  ViewController.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 17/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loadRepositore = RepositoreSession()
    
    var page = 1;
    var perPage = 30;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadRepositore.getAllRepositores(page: page, perPage: perPage) { (object) in
            
        }
    }


}

