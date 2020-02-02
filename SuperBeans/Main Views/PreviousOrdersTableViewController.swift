//
//  PreviousOrdersTableViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 02/02/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit

class PreviousOrdersTableViewController: UITableViewController {

    
    //MARK: vars
    var itemArray : [Items] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        loadItems()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
            
        cell.generateCell(itemArray[indexPath.row])

        return cell
    }
    
    //MARK: Load Items
    private func loadItems(){
        downloadItems(MUser.currentUser()!.purchasedItemsIds) { (allItems) in
                   
                   self.itemArray = allItems
                   print("we have \(allItems.count) purchased items")
                   self.tableView.reloadData()
               }
    }
    

}
