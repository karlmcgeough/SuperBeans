//
//  BasketViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 11/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import JGProgressHUD

class BasketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    //var item: Items!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var checkOutButtonOutlet: UIButton!
    
    @IBOutlet weak var basketTotalPriceLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemsInBasketLbl: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var currentTimeLbl: UILabel!
    
  //MARK: - Vars
        var basket: Basket?
        var allItems: [Items] = []
        var purchasedItemIds : [String] = []
    var pickerData: [String] = [String]()
    var orderTime = Int()
    
        let hud = JGProgressHUD(style: .dark)
        
        //MARK: - View Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()
            itemsInBasketLbl.underline()
            totalItemsLabel.underline()
            tableView.tableFooterView = footerView
            
            self.locationPicker.delegate = self
            self.locationPicker.dataSource = self
           // self.locationPicker.layer.borderColor = #colorLiteral(red: 0.2828149498, green: 0.8936786056, blue: 0.8510270119, alpha: 0.8470588235)
            //self.locationPicker.layer.borderWidth = 1.5
            //self.locationPicker.layer.backgroundColor = #colorLiteral(red: 0.2828149498, green: 0.8936786056, blue: 0.8510270119, alpha: 0.8470588235)
            self.locationPicker.layer.cornerRadius = 10
            
            
            pickerData = ["Cathedral Quarter", "Botantic", "City Center"]
            
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            //TODO: Check if user is logged in
            
            loadBasketFromFirestore()
           // currentTime()
        }
    
    @IBAction func sliderAction(_ sender: Any) {
        let myFloat: Float = timeSlider.value
        let myInt = Int(myFloat)
        orderTime = myInt
        timeLbl.text = "\(myInt) Mins"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
       }
    var selectedLocation: String?
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedLocation = pickerData[row]
        
        return pickerData[row]
    }
       
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        
        if basket != nil{
            self.createNewOrder()
            self.hud.textLabel.text = "Order Placed Successfully!"
            self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
            clearBasket()
        }else{
            self.hud.textLabel.text = "Add Items To Place Order!"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.5)
        }
        
        
    }
    
    //MARK: - create new order
          
    //MARK: Save item to firebase firestore
    private func createNewOrder(){
        //let pickerSelected = pickerData.count as? String
        let order = Order()
        order.id = UUID().uuidString
        order.ownerId = basket?.ownerId
        order.itemsIds = basket?.itemIds
        order.orderLocation = selectedLocation
        order.collectionTime = ("\(orderTime) Mins")
                
               saveOrderToFirebase(order)
        
                //self.dismissView()
    }
    
    
        //MARK: - Download basket
        private func loadBasketFromFirestore() {
            
            downloadBasket("1234") { (basket) in
                
                self.basket = basket
                self.getBasketItems()
            }
        }
        
        private func getBasketItems() {
            
            if basket != nil {
                
                downloadItems(basket!.itemIds) { (allItems) in
                    
                    self.allItems = allItems
                    self.updateTotalLabels(false)
                    self.tableView.reloadData()
                    self.checkoutButtonStatus()
                   
                }
            }
        }
    //MARK: Helper functions
    func currentTime(){
        
        //getting current date/time
        let currentDateTime = Date()
        
        //initailse date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        
        //gets the date and time string from date object
        let timeString = formatter.string(from: currentDateTime)
        
        
        currentTimeLbl.text = timeString
    }
    //MARK: - Helper functions
    
    private func updateTotalLabels(_ isEmpty: Bool) {
        
        if isEmpty {
            totalItemsLabel.text = "0"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        } else {
            totalItemsLabel.text = "\(allItems.count)"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        }
    }
    private func returnBasketTotalPrice() -> String {
        
        var totalPrice = 0.0
        
        for item in allItems {
            totalPrice += item.price
        }
        
        return "Total price: " + convertToPrice(totalPrice)
    }
    
    private func showItemView(withItem: Items){
        let itemDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemDetailView") as! ItemDetailsViewController
        itemDetailVC.item = withItem
              
              self.navigationController?.pushViewController(itemDetailVC, animated: true)
          
    }
    
    private func checkoutButtonStatus(){
        checkOutButtonOutlet.isEnabled = allItems.count > 0
        
        if checkOutButtonOutlet.isEnabled{
            checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.9709146619, green: 0.4951640368, blue: 0.4780865908, alpha: 0.8470588235)
        }else {
            disableCheckoutBtn()
        }
    }
    
    private func disableCheckoutBtn(){
        checkOutButtonOutlet.isEnabled = false
        checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    private func removeItemFromBasket(itemId: String){
        
        for i in 0..<basket!.itemIds.count {
            if itemId == basket!.itemIds[i]{
                basket!.itemIds.remove(at: i)
                return
            }
        }
    }
    
    //Clear basket once checkout button pressed
    private func clearBasket(){
        allItems.removeAll()
        tableView.reloadData()
        
        basket?.itemIds = []
        
        updateBasketInFirestore(basket!, withValues: [kITEMSIDS: basket!.itemIds!]) { (error) in
            if error != nil {
                print("error updating basket", error!.localizedDescription)
            }
            self.getBasketItems()
        }
    }
    }

//MARK: Extensions

    extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allItems.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
             
             cell.generateCell(allItems[indexPath.row])
             
             return cell
             
         }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            
            allItems.remove(at: indexPath.row)
            tableView.reloadData()
            
            removeItemFromBasket(itemId: itemToDelete.id)
            
            updateBasketInFirestore(basket!, withValues: [kITEMSIDS : basket!.itemIds]) { (error) in
                if error != nil{
                    print("error updating basket", error?.localizedDescription)
                }
                self.getBasketItems()
            }
         }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            showItemView(withItem: allItems[indexPath.row])
        }
    }

    func downloadItems(_ withIds: [String], completion: @escaping (_ itemArray: [Items]) ->Void) {
        
        var count = 0
        var itemArray: [Items] = []
        
        if withIds.count > 0 {
            
            for itemId in withIds {
                
                FirebaseReference(.Items).document(itemId).getDocument { (snapshot, error) in
                    
                    guard let snapshot = snapshot else {
                        completion(itemArray)
                        return
                    }
                    
                    if snapshot.exists {
                        
                        itemArray.append(Items(_dictionary: snapshot.data()! as NSDictionary))
                        count += 1
                        
                    } else {
                        completion(itemArray)
                    }
                    
                    if count == withIds.count {
                        completion(itemArray)
                    }
                    
                }
            }
        } else {
            completion(itemArray)
        }
        
        
    }
