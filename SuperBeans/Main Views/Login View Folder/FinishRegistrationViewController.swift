//
//  FinishRegistrationViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 25/01/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD

class FinishRegistrationViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    
    //MARK: - Vars
        let hud = JGProgressHUD(style: .dark)

        
        
        //MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            
            firstNameTxt.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            lastNameTxt.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            addressTxt.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        
        //MARK: - IBActions
        
    @IBAction func doneBtnPressed(_ sender: Any) {
        finishRegistration()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            
            print("text field did change")
            updateDoneButtonStatus()
        }

    //MARK: Helper
    private func updateDoneButtonStatus() {
        
        if firstNameTxt.text != "" && lastNameTxt.text != "" && addressTxt.text != "" {
            
            doneBtn.backgroundColor = #colorLiteral(red: 0.9709146619, green: 0.4951640368, blue: 0.4780865908, alpha: 0.8470588235)
            doneBtn.isEnabled = true
        } else {
            doneBtn.backgroundColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        }
        
    }
    
    private func finishRegistration(){
    let withValues = [kFIRSTNAME : firstNameTxt.text!, kLASTNAME : lastNameTxt.text!, kONBOARD : true, kFULLADDRESS : addressTxt.text!, kFULLNAME : (firstNameTxt.text! + " " + lastNameTxt.text!)] as [String : Any]
            
            
            updateCurrentUserInFirestore(withValues: withValues) { (error) in
                
                if error == nil {
                    self.hud.textLabel.text = "Updated!"
                    self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)

                    self.dismiss(animated: true, completion: nil)
                } else {
                    
                    print("error updating user \(error!.localizedDescription)")
                    
                    self.hud.textLabel.text = error!.localizedDescription
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                }
            }
        }

}
