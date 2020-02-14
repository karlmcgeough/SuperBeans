//
//  WelcomeViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 13/01/2020.
//  Copyright © 2020 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView

class WelcomeViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var resendEmailBtn: UIButton!
    
    
    //MARK: Vars
    let hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60.0, height: 60.0), type: .ballPulse, color: #colorLiteral(red: 0.9709146619, green: 0.4951640368, blue: 0.4780865908, alpha: 0.8470588235), padding: nil)
    
    }

    
//MARK: IBActions
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismissView()
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
       print("login")
               if textFieldsNotEmpty() {
                   
                   loginUser()
               } else {
                   hud.textLabel.text = "All fields are required"
                   hud.indicatorView = JGProgressHUDErrorIndicatorView()
                   hud.show(in: self.view)
                   hud.dismiss(afterDelay: 2.0)
               }

           }

    @IBAction func registerBtn(_ sender: Any) {
        
       print("register")
            
            if textFieldsNotEmpty() {
                
                registerUser()
            } else {
                hud.textLabel.text = "All fields are required"
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
            }

        }

    @IBAction func forgotPasswordBtn(_ sender: Any) {
        if emailTxt.text != "" {
            resetThePassword()
        } else {
            hud.textLabel.text = "Please insert email!"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
        }
        
    }
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        MUser.resendVerificationEmail(email: emailTxt.text!) { (error) in
            
            print("error resending email", error?.localizedDescription)
        }
        
    }
    //MARK: Register User
    private func registerUser() {
           
           showLoadingIndicator()
           
           MUser.registerUserWith(email: emailTxt.text!, password: passwordTxt.text!) { (error) in
               
               if error == nil {
                   self.hud.textLabel.text = "Verification Email sent!"
                   self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                   self.hud.show(in: self.view)
                   self.hud.dismiss(afterDelay: 2.0)
               } else {
                   print("error registering", error!.localizedDescription)
                   self.hud.textLabel.text = error!.localizedDescription
                   self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                   self.hud.show(in: self.view)
                   self.hud.dismiss(afterDelay: 2.0)
               }
               
               
               self.hideLoadingIndicator()
           }
           
       }

    //MARK: - Login User
    
    private func loginUser() {
        
        showLoadingIndicator()
        
        MUser.loginUserWith(email: emailTxt.text!, password: passwordTxt.text!) { (error, isEmailVerified) in
            
            if error == nil {
                
                if  isEmailVerified {
                    self.dismissView()
                    print("Email is verified")
                } else {
                    self.hud.textLabel.text = "Please Verify your email!"
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                    self.resendEmailBtn.isHidden = false
                }
                
            } else {
                print("error loging in the iser", error!.localizedDescription)
                self.hud.textLabel.text = error!.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
            
            
            self.hideLoadingIndicator()
        }
        
    }

    
    
    //MARK: Helpers
    
    private func resetThePassword() {
           
           MUser.resetPasswordFor(email: emailTxt.text!) { (error) in
               
               if error == nil {
                   self.hud.textLabel.text = "Reset password email sent!"
                   self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                   self.hud.show(in: self.view)
                   self.hud.dismiss(afterDelay: 2.0)
               } else {
                   self.hud.textLabel.text = error!.localizedDescription
                   self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                   self.hud.show(in: self.view)
                   self.hud.dismiss(afterDelay: 2.0)
               }
           }
    }

    
    
    private func textFieldsNotEmpty() -> Bool {
        return(emailTxt.text != "" && passwordTxt.text != "")
    }
    
    
    private func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Activity Indicator
    
    private func showLoadingIndicator(){
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    private func hideLoadingIndicator(){
        if activityIndicator != nil{
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
       }
}
