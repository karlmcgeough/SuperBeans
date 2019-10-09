//
//  ItemTableViewCell.swift
//  TestStore
//
//  Created by Karl McGeough on 07/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    
    @IBOutlet weak var itemDescriptionLbl: UILabel!
    
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
      
    }
    
    func generateCell(_ item: Items){
        itemNameLbl.text = item.name
        itemDescriptionLbl.text = item.description
        itemPriceLbl.text = "\(item.price!)"
        itemImageView.layer.cornerRadius = 10
        
        //MARK: download image
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.itemImageView.image = images.first as? UIImage
            }
        }
        
    }

}
