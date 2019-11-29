//
//  Order.swift
//  TestStore
//
//  Created by Karl McGeough on 08/11/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation

class Order {
    var id: String!
    var ownerId: String!
    var userId: String!
    var itemsIds: [String]!
    var orderLocation: String!
    var collectionTime: String!
    
    init() {
           
       }
       
       init(_dictionary: NSDictionary) {
            id = _dictionary[kOBJECTID] as? String
            ownerId = _dictionary[kOWNERID] as? String
            itemsIds = _dictionary[kITEMSIDS] as? [String]
            orderLocation = _dictionary[kORDERLOCATION] as? String
            collectionTime = _dictionary[kCOLLECTIONTIME] as? String
        //add user id
           
       }
}

//MARK: save to firestore
func saveOrderToFirebase(_ order: Order){
    FirebaseReference(.Order).document(order.id).setData(orderDictionaryFrom(order) as! [String: Any])
}

func orderDictionaryFrom(_ order: Order) -> NSDictionary {
    
    return NSDictionary(objects: [order.id, order.ownerId, order.itemsIds, order.orderLocation, order.collectionTime], forKeys: [kOBJECTID as NSCopying, kOWNERID as NSCopying, kITEMSIDS as NSCopying, kORDERLOCATION as NSCopying, kCOLLECTIONTIME as NSCopying])
}
