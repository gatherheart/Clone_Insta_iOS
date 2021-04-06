//
//  TabBarItemFactory.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit

protocol TabBarItemMakable {
    static func item(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController.Type) -> UINavigationController

}

class TabBarItemFactory: TabBarItemMakable {
    
    static func item(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController.Type) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController.init())
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
}
