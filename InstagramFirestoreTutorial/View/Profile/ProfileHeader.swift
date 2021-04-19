//
//  ProfileHeader.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/20.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    static let reuseIdentifier = "ProfileHeader"
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .systemPink
    }

}
