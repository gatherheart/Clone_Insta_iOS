//
//  UserCell.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import UIKit
import SnapKit
import Kingfisher

class UserCell: UITableViewCell {
    
    public static let reuseIdentifier: String = "UserCell"
    private let profileImageSize: CGFloat = 48
    
    var viewModel: UserCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "venom-7")
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Test"
        return label
    }()

    private let fullnameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Test Test"
        label.textColor = .lightGray
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [usernameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setProfileImage()
        setLabelStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProfileImage()
        setLabelStackView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
        profileImage.kf.setImage(with: viewModel.profileImageUrl)
    }
    
    private func setProfileImage() {
        profileImage.layer.cornerRadius = profileImageSize / 2.0
        self.contentView.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.height.equalTo(profileImageSize)
            make.width.equalTo(profileImageSize)
        }
    }
    
    private func setLabelStackView() {
        self.contentView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(profileImage.snp.right).offset(8)
        }
    }

}
