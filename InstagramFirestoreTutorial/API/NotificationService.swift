//
//  NotificationService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/06/09.
//

import Foundation
import Firebase
import Promises

struct NotificationService {
    func uploadNotification(uid: String, type: Notification.Category, post: Post? = nil) -> Promise<Bool> {
        
        return Promise<Bool> { fulfill, reject in
            guard let currentUid = User.me?.uid, uid != currentUid, let post = post else {
                reject(AuthErrors.notFoundUser)
                return
            }
            let documentReference: DocumentReference = FireBaseCollections.notifications.document(uid).collection("user-notifications").document()

            let data: [String: Any] = ["id": documentReference.documentID,
                                       "timestmap": Timestamp(date: Date()),
                                       "uid": currentUid,
                                       "type": type.rawValue,
                                       "postId": post.postId,
                                       "postImageUrl": post.imageUrl]

            documentReference.setData(data) {_ in
                fulfill(true)
            }
        }
    }

    func fetchNotifications() -> Promise<[Notification]> {
        return Promise<[Notification]> { fulfill, reject in
            guard let uid = User.me?.uid else {
                reject(AuthErrors.notFoundUser)
                return
            }

            let collectionReference: CollectionReference = FireBaseCollections.notifications.document(uid).collection("user-notifications")
            
            collectionReference.getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    reject(NetworkErrorCase.cacheError)
                    return
                }
                let notifications: [Notification] = documents.map { Notification(dictionary: $0.data()) }
                fulfill(notifications)
            }
        }
        
    }
}
