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
    
    init(user: User) {
        self.user = user
    }
}
