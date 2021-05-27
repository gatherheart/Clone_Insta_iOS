//
//  CommentViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/26.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment

    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }

    init(comment: Comment) {
        self.comment = comment
    }

    func commentLabelText() -> NSAttributedString {
        let attributedString: NSMutableAttributedString = .init(string: "\(comment.username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }

    func size(forWidth width: CGFloat) -> CGSize {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.frame.size = CGSize(width: width, height: label.frame.height)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
