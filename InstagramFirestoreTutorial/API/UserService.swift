//
//  UserService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import FirebaseAuth
import Promises


struct UserService {
    
    enum UserServiceError: Error {
        case currentUserAuthError
        case serverError
        case noSnapShotData
    }
    
    static func fetchUsers() -> Promise<User> {
        return Promise<User> { fulfill, reject in
            guard let uid = Auth.auth().currentUser?.uid else { reject(UserServiceError.currentUserAuthError); return }
            FireBaseCollections.users.document(uid).getDocument { snapshot, error in
                if let error = error {
                    reject(error)
                }
                guard let dictionary = snapshot?.data() else { reject(UserServiceError.noSnapShotData); return }
                let user = User(from: dictionary)
                fulfill(user)
            }
        }

        
    }
}
