//
//  NotificationCell.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/06/09.
//

import UIKit
import SnapKit
import Kingfisher

final class NotificationCell: UITableViewCell {
    static let identifier: String = "NotificationCell"

    private let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "send2")
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Profile"
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let tapRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(postButtonTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapRecognizer)
        
        return imageView
    }()
    
    private let followButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.width.height.equalTo(48)
        }
        profileImageView.layer.cornerRadius = 48 / 2
        
        
        self.contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        self.contentView.addSubview(followButton)
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.width.equalTo(100)
            make.height.equalTo(32)
        }
        
        self.contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.width.height.equalTo(40)
        }
        
        followButton.isHidden = true
    }
    
    func configure(notification: Notification) {
        self.infoLabel.text = notification.username
        self.profileImageView.kf.setImage(with: URL(string: notification.userProfileImageUrl ?? ""))
    }
    
    @objc private func followButtonTapped() {
    }
    
    @objc private func postButtonTapped() {
    }
}
