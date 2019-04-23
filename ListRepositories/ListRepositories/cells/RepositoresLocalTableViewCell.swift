//
//  RepositoresLocalTableViewCell.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 23/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit

class RepositoresLocalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageRepositore: UIImageView!
    @IBOutlet weak var nameRepositore: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var starsRepositore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepare(with repositore: Repositores){
        nameRepositore.text = repositore.fullName
        nameUser.text = repositore.login
    }

}
