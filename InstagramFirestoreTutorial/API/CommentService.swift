//
//  CommentService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/26.
//

import Firebase
import Promises

struct CommentService {
    static func uploadComment(comment: String, postId: String, user: User) -> Promise<Comment> {
        return Promise<Comment> { fulfill, reject in
            let data: [String: Any] = ["uid": user.uid,
                                       "comment": comment,
                                       "timestamp": Timestamp(date: Date()),
                                       "username": user.username,
                                       "profileImageUrl": user.profileImageUrl]
            FireBaseCollections.posts.document(postId).collection("comments").addDocument(data: data) { error in
                if let error = error {
                    reject(error)
                    return
                }
                fulfill(Comment(dictionary: data))
            }
        }
    }
    
    static func fetchComments(forPost postID: String) -> Promise<[Comment]> {
        return Promise<[Comment]> { fulfill, reject in
            var comments: [Comment] = []
            let query: Query = FireBaseCollections.posts.document(postID).collection("comments").order(by: "timestamp", descending: true)
            
            query.addSnapshotListener { snapshot, error in
                snapshot?.documentChanges.forEach { change in
                    if change.type == .added {
                        let data: [String: Any] = change.document.data()
                        let comment: Comment = .init(dictionary: data)
                        comments.append(comment)
                    }
                }
                fulfill(comments)
            }
        }
    }
}
