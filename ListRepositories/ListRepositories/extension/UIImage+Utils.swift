//
//  UIImage+Utils.swift
//  ListRepositories
//
//  Created by Erick Kaique da Silva on 22/04/2019.
//  Copyright © 2019 Erick Kaique da Silva. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func setImage(from string: String?){
        guard let imageURLString = string else {
            self.image = UIImage(named: "user")
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "user")
            }
        }
    }
    
}
