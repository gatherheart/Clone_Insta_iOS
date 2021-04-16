//
//  ImageUploader.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/16.
//

import UIKit

struct ImageUploader {
    static func upload(image: UIImage, firestoreManger: FirestoreManable, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.90) else { return }
        do {
            try firestoreManger.upload(data: imageData) { (from, metaData, error) in
                guard let from = from else { completion(.failure(error!)); return; }
                firestoreManger.downloadURL(from: from) { (imageUrl, error) in
                    completion(.success(imageUrl!))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
