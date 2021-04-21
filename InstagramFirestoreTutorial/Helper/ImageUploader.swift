//
//  ImageUploader.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/16.
//

import UIKit
import Promises

struct ImageUploader {
    static func upload(image: UIImage, firestoreManger: FirestoreManable) -> Promise<String> {
        return Promise { fulfill, reject in
            guard let imageData = image.jpegData(compressionQuality: 0.90) else { return }
            firestoreManger.upload(data: imageData)
                .then { result -> Promise<String> in
                    let (reference, _) = result
                    if let from = reference {
                        return firestoreManger.downloadURL(from: from)
                    } else {
                        throw NetworkErrorCase.invalidURL
                    }
                }.then { imageUrl in
                    fulfill(imageUrl)
                }.catch { error in
                    print(error)
                }
        }
        
    }
}
