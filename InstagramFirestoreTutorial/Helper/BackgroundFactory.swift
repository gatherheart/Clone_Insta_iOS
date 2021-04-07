//
//  BackgroundFactory.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

class BackgroundFactory {
    static func background(frame: CGRect, colors: [CGColor], locations: [NSNumber]) -> CALayer {
        return BackgroundFactory.gradientBackground(frame: frame, colors: colors, locations: locations)
    }
    static private func gradientBackground(frame: CGRect, colors: [CGColor], locations: [NSNumber]) -> CALayer {
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.frame = frame
        return gradient
    }
}
