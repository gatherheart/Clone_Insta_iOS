//
//  CustomTextField.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        leftViewMode = .always
    }
}
