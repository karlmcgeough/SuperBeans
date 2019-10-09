//
//  AddItemsViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 07/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemsViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    
    //MARK: Vars
    var category:Category!
    var imageGallery: GalleryController!
    let hud = JGProgressHUD(style: .light)
    
    var activityIndicator: NVActivityIndicatorView?
    
    var itemImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
//MARK: IBACtions
    
    @IBAction func doneBtn(_ sender: Any) {
        dismissKeyboard()
        
        if checkForValues() {
            saveItemToFirebase()
        }else{
            print("Error all fields are required")
            //TODO: show error message to user
        }
    }
    
    
    @IBAction func imageBtn(_ sender: Any) {
        itemImages = []
        displayImageGallery()
    }
    
    @IBAction func dismissKeyboardTap(_ sender: Any) {
        dismissKeyboard()
    }
    
    //MARK: Helper functions
    
    private func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    private func checkForValues() -> Bool{
        return (titleTxt.text != "" && priceTxt.text != "" && descriptionTxt.text != "")
    }
    
    private func dismissView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Save item to firebase firestore
    private func saveItemToFirebase(){
        
        let item = Items()
        item.id = UUID().uuidString
        item.name = titleTxt.text!
        item.categoryId = category.id
        item.price = Double(priceTxt.text!)
        item.description = descriptionTxt.text!
        
        if itemImages.count > 0{
            
            uploadImage(images: itemImages, itemId: item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                
               saveItemToFirestore(item)
                self.CreateSuccessAlert(title: "Success", message: "The menu item has been added!")
                //self.dismissView()
                
            }
            
        }else{
            saveItemToFirestore(item)
            dismissView()
        }
    }
    
    //MARK: Show the gallery
    
    private func displayImageGallery(){
        self.imageGallery = GalleryController()
        self.imageGallery.delegate = self
         
        Config.tabsToShow = [.imageTab]
        Config.Camera.imageLimit = 1
        
        self.present(self.imageGallery, animated: true, completion: nil)
    }
    
   private func CreateSuccessAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
        //performSegue(withIdentifier: "AddRecipeSW", sender: self)
    
    }
    
    
}

extension AddItemsViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0{
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
