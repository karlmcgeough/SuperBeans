//
//  EditProfileViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 30/01/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD

class EditProfileViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var editFirstNameTxt: UITextField!
    
    @IBOutlet weak var editLastNameTxt: UITextField!
    
    @IBOutlet weak var editAddressTxt: UITextField!
    
    //MARK: Vars
    
    let hud = JGProgressHUD(style: .dark)
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
         loadUserInfo()
        
    }
    
    //MARK: Actions
    
    @IBAction func saveBarBtnPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        
        logUserOut()
        
    }
    
    //MARK: logout user func
    
    private func logUserOut(){
      MUser.logOutCurrentUser { (error) in
                
                if error == nil {
                    print("logged out")
                    self.navigationController?.popViewController(animated: true)
                }  else {
                    print("error login out ", error!.localizedDescription)
                }
            }
            
        }

    
    
    //MARK: - UpdateUI
        
        private func loadUserInfo() {
            
            if MUser.currentUser() != nil {
                let currentUser = MUser.currentUser()!
                
                editFirstNameTxt.text = currentUser.firstName
                editLastNameTxt.text = currentUser.lastName
                editAddressTxt.text = currentUser.fullAddress
            }
        }

        
    }

    

