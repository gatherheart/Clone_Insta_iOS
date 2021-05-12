//
//  FeedCollectionViewCell.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit
import SnapKit

class FeedCollectionViewCell: UICollectionViewCell {
    public static let reuseIdentifier: String = "FeedCollectionViewCell"
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .purple
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    private lazy var username: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    public var postImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .purple
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    private lazy var like: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var comment: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var share: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "2 likes"
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "caption"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
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
        setUI()
    }
    
    private func setUI() {
        backgroundColor = .white
        setProfileImageView()
        setUsernameButton()
        setPostImage()
        setActionButtons()
        setLikesLabel()
        setCaptionLabel()
        setPostTimeLabel()
    }
    
    private func setProfileImageView() {
        self.contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.width.width.equalTo(40)
            make.top.equalTo(self.contentView.snp.top).offset(12)
            make.left.equalTo(self.contentView.snp.left).offset(12)
        }
        profileImage.layer.cornerRadius = 40 / 2
    }
    
    private func setUsernameButton() {
        self.contentView.addSubview(username)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.left.equalTo(profileImage.snp.right).offset(8)
        }
    }
    
    private func setPostImage() {
        self.contentView.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(self.contentView.snp.width)
        }
    }
    
    private func setLikesLabel() {
        self.contentView.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(like.snp.bottom).offset(-4)
            make.left.equalTo(self.contentView.snp.left).offset(8)
        }
    }
    
    private func setCaptionLabel() {
        self.contentView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(likesLabel.snp.bottom).offset(8)
            make.left.equalTo(self.contentView.snp.left).offset(8)
        }
    }
    
    private func setPostTimeLabel() {
        self.contentView.addSubview(postTimeLabel)
        postTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
            make.left.equalTo(self.contentView.snp.left).offset(8)
        }
    }
    
    private func setActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [like, comment, share])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    @objc func didTapUsername() {
        print("DEBUG: tapped username")
    }
}
