//
//  AuthUsecase.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import Foundation
import FirebaseFirestore

struct AuthUseCase {
    static func register(with: AuthCredentials, firestoreManger: FirestoreManager, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let imageData = with.profileImage.jpegData(compressionQuality: 0.90) else { return }
        do {
            try firestoreManger.upload(data: imageData) { (metaData, error) in
                print(metaData)
                AuthRequest.register(with: with) { (result) in
                    switch result {
                    case .success(let uid):
                        let data: [String: Any] = ["email": with.email,
                                                   "fullname": with.fullname,
                                                   "profileImageUrl": "",
                                                   "uid": uid,
                                                   "username": with.username]
                        print(data)
                        Firestore.firestore().collection("users").document(uid).setData(data) { _ in
                        }
                    case .failure(let error):
                        print(error)
                    case .none:
                        print("")
                    }
                }
                completion(.success(0))
            }
        } catch {
            //TODO: ERROR HANDLE
            print("ERROR HANDLE")
            completion(.failure(error))
        }
        
    }
}
