//
//  InputTextView.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/07.
//

import UIKit
import SnapKit

protocol InputTextViewDelegate: AnyObject {
    func textViewDidChange(_ textView: UITextView)
}

class InputTextView: UITextView, UITextViewDelegate {

    weak var textViewDelegate: InputTextViewDelegate?
    var placeholderText: String? {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    
    private let placeholderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.delegate = self
        self.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left).offset(8)
        }
    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        handleTextDidChange()
        textViewDelegate?.textViewDidChange(textView)
    }
    
    private func handleTextDidChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }

}
