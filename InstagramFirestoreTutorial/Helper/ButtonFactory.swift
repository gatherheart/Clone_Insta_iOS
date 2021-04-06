//
//  ButtonFactory.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

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
}
