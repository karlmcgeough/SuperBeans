//
//  ProfileTableViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 25/01/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var finishRegBtnOutlet: UIButton!
    @IBOutlet weak var orderHistoryBtnOutlet: UIButton!
    
    
    // MARK: Vars
    
    var editBarButtonOutlet: UIBarButtonItem!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //Check logged in status
        checkLoginStatus()
        checkOnboardingStatus()
        tableView.reloadData()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    //MARK: Tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        // Configure the cell...

        return UITableViewCell()
    }*/
   
//MARK: - Helpers
    
    private func checkOnboardingStatus() {
           
           if MUser.currentUser() != nil {
               
               if MUser.currentUser()!.onBoard {
                   finishRegBtnOutlet.setTitle("Account is Active", for: .normal)
                   finishRegBtnOutlet.isEnabled = false
               } else {
                   
                   finishRegBtnOutlet.setTitle("Finish registration", for: .normal)
                   finishRegBtnOutlet.isEnabled = true
                finishRegBtnOutlet.tintColor = .red
                
               }
            orderHistoryBtnOutlet.isEnabled = true
               
           } else {
               finishRegBtnOutlet.setTitle("Logged out", for: .normal)
            finishRegBtnOutlet.tintColor = .red
               finishRegBtnOutlet.isEnabled = false
               orderHistoryBtnOutlet.isEnabled = false
           }
        
       }

private func checkLoginStatus() {
       
       if MUser.currentUser() == nil {
           createRightBarButton(title: "Login")
       } else {
           createRightBarButton(title: "Edit")
       }
   }


private func createRightBarButton(title: String) {
    
    editBarButtonOutlet = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonItemPressed))
    
    self.navigationItem.rightBarButtonItem = editBarButtonOutlet
}

    
     //MARK: - IBActions
       
     @objc func rightBarButtonItemPressed() {
              
              if editBarButtonOutlet.title == "Login" {
                  showLoginView()
              } else {
                  goToEditProfile()
              }
          }

 
   private func showLoginView() {
           
           let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
           
           self.present(loginView, animated: true, completion: nil)
       }
       
       private func goToEditProfile() {
        performSegue(withIdentifier: "profileToEdit", sender: self)
       }

}

