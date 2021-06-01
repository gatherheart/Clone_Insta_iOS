//
//  User.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import Foundation

struct User: Hashable {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    let identifier = UUID()
    var isFollowed: Bool = false
    
    static var _me: User?
    static var me: User? {
        if _me == nil {
            UserService.fetchUser().then { user in
                _me = user
            }
        }
        return _me
    }
    
    var isMe: Bool {
        return UserService.isMe(uid: self.uid)
    }
    var stats: UserStats

    init(from dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}

struct UserStats {
    var followers: Int = 0
    var following: Int = 0
}
