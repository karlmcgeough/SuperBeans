//
//  HomeViewController.swift
//  SuperBeans
//
//  Created by Karl McGeough on 02/12/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import CTHelp

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func HelpBtn(_ sender: Any) {
        showHelp()
    }
    
    //REFERNCE : CTHelp Created by - StewartLynch, slynch@createchsol.com
    func showHelp() {
        let help = CTHelp()
        
        help.ctActionButtonBGColor = #colorLiteral(red: 0.9709146619, green: 0.4951640368, blue: 0.4780865908, alpha: 0.8470588235)
        
        
        help.new(CTHelpItem(title:"Welcome",
                              helpText: "",
                              imageName:"My Post-15"))
        help.new(CTHelpItem(title:"Need Help To Pre-Order?",
                              helpText: "Begin by having a browse of the menu using the tab menu at the bottom and select menu!",
                              imageName:"teaImg"))
        help.new(CTHelpItem(title:"Need Help To Pre-Order?",
                              helpText: "Once on the menu you can browse through the different categories. If you see an item you want to order click the shopping basket icon to add it to the basket, once finished browsing you can go to the shopping cart using the tab menu at the bottom to place your order.",
                              imageName:""))
        
        help.appendDefaults(companyName: "SuperBeans", emailAddress: "superbeans@hotmail.com", data: nil, webSite: "https://www.superbeans.co.uk", companyImageName: "AppIcon")

        help.presentHelp(from: self)
    }
    
}
