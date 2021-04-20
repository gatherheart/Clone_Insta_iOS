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
    
    private lazy var postLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 1, label: "posts")
        return label
    }()

    private lazy var followersLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 2, label: "followers")
        return label
    }()

    private lazy var followingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 1, label: "following")
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var gridButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()

    private lazy var listButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()

    private lazy var bookmarkButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let topDivider: UIView = {
        let view: UIView = UILabel()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
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
        setPostLabel()
        setFollowersLabel()
        setFollowingLabel()
        setLabelStackView()
        setGridButton()
        setListButton()
        setBookmarkButton()
        setButtonStackView()
        setTopDivider()
        setBottomDivider()
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
    private func setPostLabel() {
//        self.addSubview(postLabel)
//        postLabel.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setFollowersLabel() {
//        self.addSubview(followersLabel)
//        followersLabel.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setFollowingLabel() {
//        self.addSubview(followingLabel)
//        followingLabel.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setLabelStackView() {
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.left.equalTo(profileImage.snp.right).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.height.equalTo(50)
        }
    }
    private func setGridButton() {
//        self.addSubview(gridButton)
//        gridButton.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setListButton() {
//        self.addSubview(listButton)
//        listButton.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setBookmarkButton() {
//        self.addSubview(bookmarkButton)
//        bookmarkButton.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(16)
//            make.left.equalTo(self.snp.left).inset(24)
//            make.right.equalTo(self.snp.right).inset(24)
//        }
    }
    private func setButtonStackView() {
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(50)
        }
    }
    private func setTopDivider() {
        self.addSubview(topDivider)
        topDivider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(0.5)
        }
    }
    private func setBottomDivider() {
        self.addSubview(bottomDivider)
        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(0.5)
        }
    }
    @objc
    func editProfile(_ sender: UIButton) {
        print(sender)
    }
}

// MARK: - Helper
extension ProfileHeader {
    private func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText: NSMutableAttributedString = .init(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.lightGray]))
        return attributedText
    }
}
