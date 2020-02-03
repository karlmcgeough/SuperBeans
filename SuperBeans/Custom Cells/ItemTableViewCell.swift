//
//  ItemTableViewCell.swift
//  TestStore
//
//  Created by Karl McGeough on 07/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    
    @IBOutlet weak var itemDescriptionLbl: UILabel!
    
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    let hud = JGProgressHUD(style: .dark)
    var item: Items!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func generateCell(_ item: Items){
        itemNameLbl.text = item.name
        itemDescriptionLbl.text = item.description
        itemPriceLbl.text = convertToPrice(item.price)
        itemImageView.layer.cornerRadius = 20
        itemNameLbl.underline()
        itemPriceLbl.adjustsFontSizeToFitWidth = true
        //self.layer.borderColor = UIColor.black.cgColor
        //self.layer.borderWidth = 0.5
    
        
        //MARK: download image
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.itemImageView.image = images.first as? UIImage
            }
        }
        
        
    }

    @IBAction func addTocartBtn(_ sender: Any) {

}
}
      /*  downloadBasket("1234") { (basket) in
            
            if basket == nil {
                self.createNewBasket()
            } else {
                basket!.itemIds.append(self.item.id)
                self.updateBasket(basket: basket!, withValues: [kITEMSIDS : basket!.itemIds])
            }
        }
    }
 
    //MARK: - Add to basket
    
    private func createNewBasket() {
        
        let newBasket = Basket()
        newBasket.id = UUID().uuidString
        newBasket.ownerId = "1234"
        newBasket.itemIds = [self.item.id]
        saveBasketToFirebase(newBasket)
        
        self.hud.textLabel.text = "Added to basket!"
        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
       // self.hud.show(in: self)
        self.hud.dismiss(afterDelay: 2.0)
    }
    
    private func updateBasket(basket: Basket, withValues: [String : Any]) {
        
     updateBasketInFirestore(basket, withValues: withValues) { (error) in
         if error != nil {
                     
                     self.hud.textLabel.text = "Error: \(error!.localizedDescription)"
                     self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    // self.hud.show(in: self)
                     self.hud.dismiss(afterDelay: 2.0)

                     print("error updating basket", error!.localizedDescription)
                 } else {
                     
                     self.hud.textLabel.text = "Added to basket!"
                     self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                     //self.hud.show(in: self)
                     self.hud.dismiss(afterDelay: 2.0)
                 }
             }
         }*/


