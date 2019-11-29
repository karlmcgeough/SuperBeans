//
//  ItemDetailsViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 11/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD


class ItemDetailsViewController: UIViewController {

    //MARK: IbOutlets
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var descriptionTxt: UITextView!
        
    //Vars
    var item: Items!
    var itemImage: [UIImage] = []
    let hud = JGProgressHUD(style: .dark)
    
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 00.0, right: 0.0)
    private let cellHeight : CGFloat = 198
    private let itemsPerRow: CGFloat = 1
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLbl.underline()
        
        
            setupUI()
        downloadImage()
        
      self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "basketImg"), style: .plain, target: self, action: #selector(self.addToCartBtnPressed))]
    }
    

    private func downloadImage(){
        
        if item != nil && item.imageLinks != nil {
            downloadImages(imageUrls: item.imageLinks) { (allImages) in
                if allImages.count > 0 {
                    self.itemImage = allImages as! [UIImage]
                    self.imageCollectionView.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        
        if item != nil{
            self.title = item.name
            nameLbl.text = item.name
            priceLbl.text = convertToPrice(item.price)
            descriptionTxt.text = item.description
        }
        
        
    }
    //MARK: ibactions
    
    @objc func addToCartBtnPressed(){
        
        //TODO: Check if user is logged in
        
      downloadBasket("1234") { (basket) in
                
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
           self.hud.show(in: self.view)
           self.hud.dismiss(afterDelay: 2.0)
       }
       
       private func updateBasket(basket: Basket, withValues: [String : Any]) {
           
        updateBasketInFirestore(basket, withValues: withValues) { (error) in
            if error != nil {
                        
                        self.hud.textLabel.text = "Error: \(error!.localizedDescription)"
                        self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                        self.hud.show(in: self.view)
                        self.hud.dismiss(afterDelay: 2.0)

                        print("error updating basket", error!.localizedDescription)
                    } else {
                        
                        self.hud.textLabel.text = "Added to basket!"
                        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        self.hud.show(in: self.view)
                        self.hud.dismiss(afterDelay: 2.0)
                    }
                }
            }

    
}

extension ItemDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImage.count == 0 ? 1 : itemImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailImageCollectionViewCell
              
              if itemImage.count > 0 {
                  cell.generateImageWith(itemImage: itemImage[indexPath.row])
            }
              
              return cell

    }
    
    
    
    
}

extension ItemDetailsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        let availableWidth = collectionView.frame.width - sectionInsets.left
       
        
        return CGSize(width: availableWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
}
