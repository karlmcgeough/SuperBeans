//
//  FirebaseCollectionReference.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum fCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: fCollectionReference) ->
    CollectionReference{
        
        return Firestore.firestore().collection(collectionReference.rawValue)
}
