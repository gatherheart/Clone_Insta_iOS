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
        let feed = FeedController()
        let search = SearchController()
        let imageSelector = ImageSelectorController()
        let notifications = NotificationController()
        let profile = ProfileController()
        viewControllers = [feed, search, imageSelector, notifications, profile]
    }
    
}
