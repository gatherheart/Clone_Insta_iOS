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
    
    static func fetchUser() -> Promise<User> {
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
    
    static func fetchUsers() -> Promise<Array<User>> {
        return Promise<Array<User>> { fulfill, reject in
            FireBaseCollections.users.getDocuments { snapshot, error in
                guard let snapshot = snapshot else { reject(UserServiceError.noSnapShotData); return }
                let users = snapshot.documents.map({ User(from: $0.data())})
                fulfill(users)
            }
        }
    }
    
    static func isMe(uid: String) -> Bool {
        return UserService.myId() == uid
    }
    
    static func myId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    static func follow(uid: String) -> Promise<Bool> {
        return Promise<Bool> { fulfill, reject in
            guard let myId = UserService.myId() else { return }
            let followingDocument = FireBaseCollections.following.document(myId).collection("userFollowing")
            let follwersDocument = FireBaseCollections.following.document(uid).collection("userFollowers")

            followingDocument.document(uid).setData([:]) { error in
                follwersDocument.document(myId).setData([:]) { error in
                    if let error = error {
                        reject(error)
                    }
                    fulfill(true)
                }
            }
        }
        
    }
    
    static func unfollow(uid: String) -> Promise<Bool> {
        return Promise<Bool> {
            guard let myId = UserService.myId() else { return }

        }
    }
}
