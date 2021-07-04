//
//  Notification.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/06/09.
//

import Foundation
import Firebase

struct Notification {
    
    enum Category: Int {
        case like = 0
        case follow
        case comment

        var notificationMessage: String {
            switch self {
            case .like:
                return "liked your post."
            case .follow:
                return "followed you."
            case .comment:
                return "commented on your post."
            }
        }
    }
    
    let id: String
    let uid: String
    var postImageUrl: String?
    var postId: String?
    let username: String
    let userProfileImageUrl: String?
    let timestamp: Timestamp
    let type: Category

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.type = Category(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
