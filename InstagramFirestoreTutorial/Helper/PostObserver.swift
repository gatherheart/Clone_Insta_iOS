//
//  PostObserver.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/23.
//

import Foundation

class PostObserver {

    var profileImageObservation: NSKeyValueObservation?
    
    func observe(post: Post) {
        profileImageObservation = post.observe(\.ownerImageUrl, options: .new) { (post, change) in
            guard let profileImage = change.newValue as String? else { return }
            InfoLog("New is: \(profileImage)")
        }
    }
    
    deinit {
        profileImageObservation?.invalidate()
    }
}
