//
//  ProfileCell.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/20.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProfileCell"
    private var post: Post?
    
    private let postImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .gray
        setPostImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        post = nil
        postImage.kf.cancelDownloadTask()
        postImage.image = nil
    }
    
    func configure(post: Post) {
        self.post = post
        postImage.kf.setImage(with: URL(string: post.imageUrl))
    }
    
    private func setPostImage() {
        self.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }
    }
}
