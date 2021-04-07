//
//  MainTabController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    

    // MARK: - Helpers
    func configureViewController() {
        let feed = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController.self)
        let search = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController.self)
        let imageSelector = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController.self)
        let notifications = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController.self)
        let profile = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController.self)
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
    }
    
}
