//
//  DetailImageCollectionViewCell.swift
//  TestStore
//
//  Created by Karl McGeough on 11/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    func generateImageWith(itemImage: UIImage){
        itemImageView.image = itemImage
    }
    
    
}
