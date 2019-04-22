//
//  RepositoreTableViewCell.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 22/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit

class RepositoreTableViewCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameRepositore: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var countStarsRepositore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(from repositore: Repositore){
        imageUser.setImage(from: repositore.owner.avatar_url)
        nameRepositore.text = repositore.full_name
        nameUser.text = repositore.owner.login
        countStarsRepositore.text = String(repositore.stargazers_count)
    }

}
