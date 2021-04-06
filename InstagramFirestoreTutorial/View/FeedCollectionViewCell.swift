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
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .purple
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
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
        backgroundColor = .white
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(usernameButton)
        setProfileImageView()
        setUsernameButton()
    }
    
    private func setProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.width.width.equalTo(40)
            make.top.equalTo(self.contentView.snp.top).offset(12)
            make.left.equalTo(self.contentView.snp.left).offset(12)
        }
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    private func setUsernameButton() {
        usernameButton.translatesAutoresizingMaskIntoConstraints = false
        usernameButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
    }
    
    
    @objc func didTapUsername() {
        print("DEBUG: tapped username")
    }
}
