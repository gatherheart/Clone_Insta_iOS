//
//  FirestoreManager.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import FirebaseStorage
import Promises

enum FirestoreEndPoint: String {
    case basePath =  "/"
    static let profileImagePath = "/profile_images"
}

protocol FirestoreManable {
    func downloadURL(from: StorageReference) -> Promise<String>
    func upload(data: Data) -> Promise<(StorageReference?, StorageMetadata?)>
}

class FirestoreManager: FirestoreManable {
    
    func upload(data: Data) -> Promise<(StorageReference?, StorageMetadata?)> {
        let filename = UUID().uuidString
        let to = Storage.storage().reference(withPath: "\(FirestoreEndPoint.profileImagePath)/\(filename)")
        
        return Promise { fulfill, reject in
            to.putData(data, metadata: nil) { metaData, error in
                if let error = error {
                    print("DEBUG: Upload Failure \(String(describing: error.localizedDescription))")
                    reject(error)
                }
                fulfill((to, metaData))
            }
        }
    }
    
    func downloadURL(from: StorageReference) -> Promise<String> {
        return Promise { fulfill, reject in
            from.downloadURL { url, error in
                if let error = error {
                    reject(error)
                    return
                }
                guard let imageUrl = url?.absoluteString else { return }
                fulfill(imageUrl)
            }
        }
    }
    
}
