//
//  FirestoreManager.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import FirebaseStorage

enum FirestoreEndPoint: String {
    case basePath =  "/"
    static let profileImagePath = "/profile_images"
}

protocol FirestoreManable {
    func downloadURL(from: StorageReference, completion: @escaping (String?, Error?) -> Void)
    func upload(data: Data, completion: @escaping (StorageReference?, StorageMetadata?, Error?) -> Void) throws
}

class FirestoreManager: FirestoreManable {
    
    func downloadURL(from: StorageReference, completion: @escaping (String?, Error?) -> Void) {
        from.downloadURL { url, error in
            guard let imageUrl = url?.absoluteString else { return }
            completion(imageUrl, nil)
        }
    }
    
    func upload(data: Data, completion: @escaping (StorageReference?, StorageMetadata?, Error?) -> Void) throws {
        let filename = UUID().uuidString
        let to = Storage.storage().reference(withPath: "\(FirestoreEndPoint.profileImagePath)/\(filename)")
        to.putData(data, metadata: nil) { metaData, error in
            if let error = error {
                print("DEBUG: Upload Failure \(String(describing: error.localizedDescription))")
                completion(to, nil, error)
            }
            completion(to, metaData, nil)
        }
    }
    
}
