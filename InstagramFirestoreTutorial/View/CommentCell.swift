//
//  CommentCell.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/25.
//

import UIKit
import SnapKit

class CommentCell: UICollectionViewCell {

    static let identifier: String = "CommentCell"
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label: UILabel = UILabel()
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Bean ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Test comment here", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
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
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(commentLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(8)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.height.equalTo(40)
        }
        profileImageView.layer.cornerRadius = 40 / 2

        commentLabel.snp.makeConstraints { make in
            make.left.equalTo(self.profileImageView.snp.right).offset(8)
            make.centerY.equalTo(self.profileImageView.snp.centerY)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
//        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 80)
        return layoutAttributes
    }
}
