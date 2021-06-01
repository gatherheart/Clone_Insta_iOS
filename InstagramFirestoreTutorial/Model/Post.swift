//
//  Post.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/12.
//

import Firebase

class Post: NSObject {
    var caption: String
    var likes: Int
    var isLiked: Bool = false
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    @objc dynamic var ownerImageUrl: String
    @objc dynamic var ownerUsername: String
    
    init(postId: String, dictionary: PostData) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
