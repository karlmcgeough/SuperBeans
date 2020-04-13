//
//  Constants.swift
//  TestStore
//
//  Created by Karl McGeough on 06/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation

enum Constats {
    static let publishableKey = "pk_test_QVYQqbrTevBmyP5HpaEwoI6A005qbgIHuN"
    static let baseURLString = "http://localhost:3000/"
    static let defaultCurrency = "gbp"
    static let defaultDescription = "Purchased From SuperBeans Coffee"
}

//IDS AND KEYS
public let kSTORAGEREFERENCE = "gs://superbeansstore.appspot.com/"

//Firebase Headers
public let kUSER_PATH = "User"
public let kCATEGORY_PATH  = "Category"
public let kITEMS_PATH = "Items"
public let kBASKET_PATH = "Basket"

//Category
public let kNAME = "name"
public let kIMAGENAME = "imageName"
public let kOBJECTID = "objectId"


//Item
public let kCATEGORYID = "categoryId"
public let kDESCRIPTION = "description"
public let kPRICE = "price"
public let kIMAGELINKS = "imageLinks"


//Basket

public let kOWNERID = "ownerId"
public let kITEMSIDS = "itemsIds"
public let kCOMMENTS = "comments"

//Order

public let kOrderID = "orderId"
public let kORDERLOCATION = "orderLocation"
public let kCOLLECTIONTIME = "collectionTime"
public let kORDERCOMPLETED = "orderCompleted"

//Favourites


//User
public let kEMAIL = "email"
public let kFIRSTNAME = "firstName"
public let kLASTNAME = "lastName"
public let kFULLNAME = "fullName"
public let kCURRENTUSER = "currentUser"
public let kFULLADDRESS = "fullAddress"
public let kONBOARD = "onBoard"
public let kPURCHASEDITEMIDS = "purchasedItemIds"

