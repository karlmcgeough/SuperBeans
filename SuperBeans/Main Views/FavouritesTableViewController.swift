//
//  FavouritesTableViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 02/02/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

    //MARK: Vars
    var favourites : Favourites!
     var allItems: [Items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: Check if user is logged in
        if MUser.currentUser() != nil {
            loadFavouritesFromFirestore()
        }else {
            showLoginView()
        }
        
    }
    //MARK: Show Login View
       private func showLoginView(){
           let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
           
           self.present(loginView, animated: true, completion: nil)
       }

    private func showItemView(withItem: Items){
           let itemDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemDetailView") as! ItemDetailsViewController
           itemDetailVC.item = withItem
                 
                 self.navigationController?.pushViewController(itemDetailVC, animated: true)
             
       }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
             
             cell.generateCell(allItems[indexPath.row])
             
             return cell
             
         }
        
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            
            allItems.remove(at: indexPath.row)
            tableView.reloadData()
            
          //  removeItemFromBasket(itemId: itemToDelete.id)
            
            updateFavouritesInFirestore(favourites!, withValues: [kITEMSIDS : favourites!.itemIds]) { (error) in
                if error != nil{
                    print("error updating favourites", error?.localizedDescription)
                }
                self.getFavouritesItems()
            }
         }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            showItemView(withItem: allItems[indexPath.row])
        }
    }

    //MARK: - Download favourites
    private func loadFavouritesFromFirestore() {
        
        downloadFavourites(MUser.currentId()) { (favourites) in
            
            self.favourites = favourites
            self.getFavouritesItems()
        }
    }
    
    private func getFavouritesItems() {
        
        if favourites != nil {
            
            downloadItems(favourites!.itemIds) { (allItems) in
                
                self.allItems = allItems
                self.tableView.reloadData()
               
               
            }
        }
    }

}
