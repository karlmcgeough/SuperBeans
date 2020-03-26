//
//  Category.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation
import UIKit

class Category{
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
    }
}

//MARK: Download Category
func downloadCategoriesFromFirebase(completion: @escaping (_ categoryArray: [Category]) -> Void){
    
    var categoryArray: [Category] = []
    
    FirebaseReference(.Category).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else{
            completion(categoryArray)
            return
    }
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents{
                print("Created New Category with")
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary ))
        }
            
            completion(categoryArray)
            //test
}
    }
    

//MARK: save category function

func saveCategoryToFirebase(_ category: Category){
    
    let id = UUID().uuidString
    category.id = id
    
    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}

//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary{
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}


//use only to create categories
/*func createCategorySet(){
    
    let coffee = Category(_name: "Coffee", _imageName: "coffeeImg")
    let tea = Category(_name: "Tea", _imageName: "teaImg")
    let decaf = Category(_name: "Decaf", _imageName: "decafImg")
    let food = Category(_name: "Sweet Treats", _imageName: "foodImg")
    let salads = Category(_name: "Salads", _imageName: "saladsImg")
    let hotfood = Category(_name: "Hot Food", _imageName: "hotFoodImg")
    
    let arrayOfCategories = [coffee, tea, decaf, food, salads, hotfood]
    
    for category in arrayOfCategories{
        saveCategoryToFirebase(category)
    }
}*/
}
