//
//  CommentInputAccessoryView.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/25.
//

import UIKit
import SnapKit

class CommentInputAccesoryView: UIView {

    private let divider: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let commentTextView: InputTextView = {
        let textView: InputTextView = InputTextView()
        textView.placeholderText = "Enter comment"
        textView.font = .systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let postButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleCommentUpload), for: .touchUpInside)
        return button
    }()
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {

        self.addSubview(commentTextView)
        self.addSubview(divider)
        self.addSubview(postButton)
        
        divider.snp.makeConstraints { make in
            let borderWidth = 1 / UIScreen.main.scale
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(borderWidth)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self.snp.right).offset(8)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right).offset(-8)
            make.height.width.equalTo(50)
        }
    }
    
    @objc private func handleCommentUpload() {
        
    }
}
