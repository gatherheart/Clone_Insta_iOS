//
//  UserService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import FirebaseAuth
import Promises


struct UserService {
    
    enum UserCollections: String {
        case userFollowing
        case userFollowers
    }
    
    enum UserServiceError: Error {
        case invalidUserId
        case currentUserAuthError
        case serverError
        case noSnapShotData
    }
    
    static func fetchUser(uid: String? = nil) -> Promise<User> {
        return Promise<User> { fulfill, reject in
            guard let uid = uid else { reject(UserServiceError.invalidUserId); return }
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
            let followingDocument = FireBaseCollections.following.document(myId).collection(UserCollections.userFollowing.rawValue)
            let followersDocument = FireBaseCollections.following.document(uid).collection(UserCollections.userFollowers.rawValue)

            followingDocument.document(uid).setData([:]) { error in
                if let error = error {
                    reject(error)
                }
                followersDocument.document(myId).setData([:]) { error in
                    if let error = error {
                        reject(error)
                    }
                    fulfill(true)
                }
            }
        }
        
    }
    
    static func unfollow(uid: String) -> Promise<Bool> {
        return Promise<Bool> { fulfill, reject in
            guard let myId = UserService.myId() else { return }
            let followingDocument = FireBaseCollections.following.document(myId).collection(UserCollections.userFollowing.rawValue)
            let followersDocument = FireBaseCollections.following.document(uid).collection(UserCollections.userFollowers.rawValue)
            
            followingDocument.document(uid).delete() { error in
                if let error = error {
                    reject(error)
                }
                followersDocument.document(myId).delete() { error in
                    if let error = error {
                        reject(error)
                    }
                    fulfill(true)
                }
            }
        }
    }
    
    static func isFollowed(uid: String) -> Promise<Bool> {
        return Promise { fulfill, reject in
            guard let myId = UserService.myId() else { return }
            let followingDocument = FireBaseCollections.following.document(myId).collection(UserCollections.userFollowing.rawValue)
            followingDocument.document(uid).getDocument() { snapshot, error in
                guard let isFollowed = snapshot?.exists else { fulfill(false); return }
                if let error = error {
                    reject(error)
                }
                fulfill(isFollowed)
            }
        }
    }
    
    static func fetchUserStats(uid: String) -> Promise<UserStats> {
        return Promise { fulfill, reject in
            let followingDocument = FireBaseCollections.following.document(uid).collection(UserCollections.userFollowing.rawValue)
            let followersDocument = FireBaseCollections.following.document(uid).collection(UserCollections.userFollowers.rawValue)
            
            followingDocument.getDocuments { snapshot, error in
                if let error = error {
                    reject(error)
                }
                let followings = snapshot?.count ?? 0
                followersDocument.getDocuments { snapshot, error in
                    let followers = snapshot?.count ?? 0
                    fulfill(UserStats(followers: followers, following: followings))
                }
                
            }
        }
        
    }
}
