//
//  AuthUsecase.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import Foundation

struct AuthUseCase {
    static func register(with: AuthCredentials, firestoreManger: FirestoreManager, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let imageData = with.profileImage.jpegData(compressionQuality: 0.90) else { return }
        do {
            try firestoreManger.upload(data: imageData) { (metaData, error) in
                print(metaData)
                completion(.success(0))
            }
        } catch {
            //TODO: ERROR HANDLE
            print("ERROR HANDLE")
            completion(.failure(error))
        }
        
    }
}
