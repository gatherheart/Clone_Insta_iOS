//
//  AuthUsecase.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

typealias UserType = [String: Any]

struct AuthUseCase {

    static func checkLoggedIn() -> Bool {
        return AuthRequest.checkLoggedIn()
    }
    
    static func register(with: AuthCredentials, firestoreManger: FirestoreManable, completion: @escaping (Result<UserType, Error>) -> Void) {
        ImageUploader.upload(image: with.profileImage, firestoreManger: firestoreManger) { result in
            
            switch result {
            case .success(let imageUrl):
                requestRegistration(with: with, imageUrl: imageUrl) { user, error in
                    completion(.success(user!))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func login(withEmail: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> ()) {
        AuthRequest.login(withEmail: withEmail, password: password) { result, error in
            completion(result, error)
        }
    }
    
    static func logout(completion: @escaping (Error?)->()) {
        AuthRequest.logout() { error in
            completion(error)
        }
    }
    
    private static func requestRegistration(with: AuthCredentials, imageUrl: String, completion: @escaping (UserType?, Error?) -> Void) {
        AuthRequest.register(with: with) { (result) in
            switch result {
            case .success(let uid):
                let data: [String: Any] = ["email": with.email,
                                           "fullname": with.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": with.username]
                FireBaseCollections.users.document(uid).setData(data) { _ in
                    completion(data, nil)
                }
            case .failure(let error):
                completion(nil, error)
            case .none:
                completion(nil, nil)
            }
        }
    }
}
