//
//  ItemsTableViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 07/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD

class ItemsTableViewController: UITableViewController {

    //MARK: vars
    
    var category: Category?
    
    var itemArray: [Items] = []
     var item: Items!
    let hud = JGProgressHUD(style: .light)
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        self.title = category?.name
       // print("We have selected", category?.name)
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if category != nil {
            downloadItems()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(itemArray[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
            cell.generateCell(itemArray[indexPath.row])

        // Configure the cell...

        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSW"{
            let vc = segue.destination as! AddItemsViewController
            vc.category = category!
        }
    }
    
    private func showItemView(_ item: Items){
        let itemDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemDetailView") as! ItemDetailsViewController
        itemDetailVC.item = item
        
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    

    
    
    //MARK: download Items
    private func downloadItems(){
        downloadItemsFromFirebase(category!.id) { (allItems) in
//            print("we have \(allItems.count) items for this category")
            self.itemArray = allItems
            self.tableView.reloadData()
        }
   }
}

