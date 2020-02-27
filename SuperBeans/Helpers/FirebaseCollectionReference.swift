//
//  FirebaseCollectionReference.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation
import FirebaseFirestore

//List of collections within firebase for app
enum fCollectionReference: String {
    case RegularUser
    case Category
    case Items
    case Basket
    case Order
    case Favourites
}
//MARK: Firebase reference
func FirebaseReference(_ collectionReference: fCollectionReference) ->
    CollectionReference{
        
        return Firestore.firestore().collection(collectionReference.rawValue)
}
