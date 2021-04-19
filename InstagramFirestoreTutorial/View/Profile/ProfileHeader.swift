//
//  ProfileHeader.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/20.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    static let reuseIdentifier = "ProfileHeader"
    private let profileImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Bean Milky"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private lazy var editProfile: UIButton = {
        let button = ButtonFactory.button(title: "Edit Profile", titleColor: .black, cornerRadius: 3, fontSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(editProfile(_:)), for: .touchUpInside)
        return button
    }()
    
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
        setProfileImage()
        setName()
        setEditProfile()
    }
    
    private func setProfileImage() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(12)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        profileImage.layer.cornerRadius = 80 / 2
    }
    private func setName() {
        self.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(12)
            make.centerX.equalTo(profileImage.snp.centerX)
        }
    }
    private func setEditProfile() {
        self.addSubview(editProfile)
        editProfile.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(16)
            make.left.equalTo(self.snp.left).inset(24)
            make.right.equalTo(self.snp.right).inset(24)
        }
    }
    
    @objc
    func editProfile(_ sender: UIButton) {
        print(sender)
    }
}
