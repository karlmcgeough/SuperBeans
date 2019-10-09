//
//  CategoryCollectionViewCell.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func gernerateCell(_ category: Category){
        nameLabel.text = category.name
        imageView.image = category.image
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = UIColor.clear.cgColor
        
       /* self.layer.shadowColor = UIColor.gray.cgColor
        //self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
       // self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.05
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath*/
    }
}
