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
        dismissKeyboard()
        
        if textFieldsHaveText() {
            
            let withValues = [kFIRSTNAME : editFirstNameTxt.text!, kLASTNAME : editLastNameTxt.text!, kFULLNAME : (editFirstNameTxt.text! + " " + editLastNameTxt.text!), kFULLADDRESS : editAddressTxt.text!]
            
            updateCurrentUserInFirestore(withValues: withValues) { (error) in
                
                if error == nil {
                    self.hud.textLabel.text = "Updated!"
                    self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                    
                } else {
                    print("erro updating user ", error!.localizedDescription)
                   self.hud.textLabel.text = error!.localizedDescription
                   self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                   self.hud.show(in: self.view)
                   self.hud.dismiss(afterDelay: 2.0)
                }
            }
            
        }
        else {
            hud.textLabel.text = "All fields are required!"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            
        }
        
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

    //MARK: - Helper funcs
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }

    private func textFieldsHaveText() -> Bool {
        
        return (editFirstNameTxt.text != "" && editLastNameTxt.text != "" && editAddressTxt.text != "")
    }

        
    }

    

