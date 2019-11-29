//
//  ImageUploadDownload.swift
//  TestStore
//
//  Created by Karl McGeough on 07/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

//MARK: Uploading Image To Firebase Firestore
func uploadImage(images: [UIImage?], itemId: String, completion: @escaping(_ imageLinks: [String]) -> Void){
    
    if Reachabilty.HasConnection() {
        
        var uploadedImagesCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
          let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
        let imageData = image!.jpegData(compressionQuality: 0.5)
            
            saveImagesToFirebaseStorage(imageData: imageData!, fileName: fileName) {
                (imageLink) in
                
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    
                    uploadedImagesCount += 1
                    
                     if uploadedImagesCount == images.count {
                                           completion(imageLinkArray)
                                       }

                }
            }
                nameSuffix += 1
        }
        
    }else{
        print("No Internet connection")
    }
}

//MARK: Saving Images To firebase storage
func saveImagesToFirebaseStorage(imageData: Data, fileName:String, completion: @escaping(_ imageLink: String?) -> Void){
    
    var task: StorageUploadTask!
    
    let storageRef = storage.reference(forURL: kSTORAGEREFERENCE).child(fileName)
    
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
            
            task.removeAllObservers()
            
            if error != nil {
                print("Error uploading image", error!.localizedDescription)
                completion(nil)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                
                completion(downloadUrl.absoluteString)
            }
        })
    }

//MARK: Downloading Images
func downloadImages(imageUrls: [String], completion: @escaping (_ images: [UIImage?]) -> Void) {
    
    var imageArray: [UIImage] = []
    
    var downloadCounter = 0
    
    for link in imageUrls {
        
        let url = NSURL(string: link)
        
        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
        
        downloadQueue.async {
            
            downloadCounter += 1
            
            let data = NSData(contentsOf: url! as URL)
            
            if data != nil {
                imageArray.append(UIImage(data: data! as Data)!)
                
                if downloadCounter == imageArray.count {
                    
                    DispatchQueue.main.async {
                        completion(imageArray)
                    }
                }
            } else {
                print("couldnt dowload image")
                completion(imageArray)
            }
        }
    }
}
