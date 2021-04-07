//
//  ButtonFactory.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

protocol ButtonMakable {
    static func button(first: String, second: String) -> UIButton
    static func button(title: String, titleColor: UIColor, backgroundColor: UIColor, cornerRadius:CGFloat, fontSize:CGFloat) -> UIButton
}

extension ButtonMakable {
    static func button(title: String="", titleColor: UIColor = .clear, backgroundColor: UIColor = .white, cornerRadius:CGFloat = 0, fontSize:CGFloat = 15) -> UIButton {
        return Self.button(title: title, titleColor: titleColor, backgroundColor: backgroundColor, cornerRadius: cornerRadius, fontSize: fontSize)
    }
}

class ButtonFactory {
    static func button(first: String, second: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(first)", attributes: attributes)
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: "\(second)", attributes: boldAttributes))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    static func button(title: String="", titleColor: UIColor = .white, backgroundColor: UIColor = .white, cornerRadius:CGFloat = 0, fontSize:CGFloat = 15) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        return button
    }
}
