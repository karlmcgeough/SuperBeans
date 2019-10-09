//
//  CategoryCollectionViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {

    //MARK: Vars
    var categoryArray: [Category] = []
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    
    //MARK: view Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //download category
        downloadCategoriesFromFirebase {(allCategories) in
                print("call Back is Completed")
        }
        //adding Categories to firebase
        //createCategorySet()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadCategories()
    }


    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
    
        cell.gernerateCell(categoryArray[indexPath.row])
        return cell
    }

    //MARK: UICollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "menutoitemsSW", sender: categoryArray[indexPath.row])
    }
    
    
    // MARK: Download categories
    
    private func loadCategories(){
        
        downloadCategoriesFromFirebase{(allCategories) in
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }
    
    //MARK: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menutoitemsSW"{
            
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
    }
    
}



extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
}
