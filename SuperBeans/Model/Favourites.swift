//
//  Favourites.swift
//  TestStore
//
//  Created by Karl McGeough on 29/11/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//
import Foundation

class Favourites {
    
    var id: String!
    var ownerId: String!
    var itemIds: [String]!
    
    init() {
        
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as? String
         ownerId = _dictionary[kOWNERID] as? String
         itemIds = _dictionary[kITEMSIDS] as? [String]
        
    }
}

//MARK: save to firestore
func saveFavouritesToFirebase(_ favourites: Favourites){
    FirebaseReference(.Favourites).document(favourites.id).setData(favouritesDictionaryFrom(favourites) as! [String: Any])
}

//MARK: Download favourites

func downloadFavourites(_ ownerId: String, completion: @escaping(_ favourites: Favourites?)-> Void){
    FirebaseReference(.Favourites).whereField(kOWNERID, isEqualTo: ownerId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else{
            completion(nil)
            return
        }
        
        if !snapshot.isEmpty && snapshot.documents.count > 0 {
            let favourites = Favourites(_dictionary: snapshot.documents.first!.data() as NSDictionary)
            completion(favourites)
        }else{
            completion(nil)
        }
    }
}

//MARK: Helper functions

func favouritesDictionaryFrom(_ favourites: Favourites) -> NSDictionary {
    
    return NSDictionary(objects: [favourites.id, favourites.ownerId, favourites.itemIds], forKeys: [kOBJECTID as NSCopying, kOWNERID as NSCopying, kITEMSIDS as NSCopying])
}

//MARK: Updating favourites

func updateFavouritesInFirestore(_ favourites: Favourites, withValues: [String : Any], completion: @escaping (_ error: Error?) -> Void) {
    
    
    FirebaseReference(.Favourites).document(favourites.id).updateData(withValues) { (error) in
        completion(error)
    }
}
