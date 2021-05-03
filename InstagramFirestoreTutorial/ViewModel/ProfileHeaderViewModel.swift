//
//  ProfileHeaderViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import UIKit
import Kingfisher

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImage: String {
        return user.profileImageUrl
    }
    var followButtonText: String {
        if user.isMe {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isMe ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isMe ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }

    var numberOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, label: "following")
    }

    var numberOfPosts: NSAttributedString {
        return attributedStatText(value: 5, label: "posts")
    }

    init(user: User) {
        self.user = user
    }
    
    private func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.lightGray]))
        return attributedText
    }
}
