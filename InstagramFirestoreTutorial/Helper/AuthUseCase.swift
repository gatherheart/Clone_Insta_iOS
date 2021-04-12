//
//  AuthUsecase.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import Foundation

struct AuthUseCase {
    static func auth(with: AuthCredentials, firestoreManger: FirestoreManager) {
        guard let imageData = with.profileImage.jpegData(compressionQuality: 0.90) else { return }
        firestoreManger.upload(data: image) { (metaData, error) in
            print(metaData)
        }
    }
}
