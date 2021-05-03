//
//  MainTabController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit

class MainTabController: UITabBarController {
    
    private var feed: UINavigationController!
    private var search: UINavigationController!
    private var imageSelector: UINavigationController!
    private var notifications: UINavigationController!
    private var profile: UINavigationController!
    private var user: User? {
        didSet {
            guard let user = user else { return }
            setUserForViewControllers(with: user)
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        fetchUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureLoginViewController()
    }

    // MARK: - Helpers
    private func configureViewController() {
        feed = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController.self)
        search = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController.self)
        imageSelector = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController.self)
        notifications = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController.self)
        profile = TabBarItemFactory.item(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController.self)
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
    }
    
    private func setUserForViewControllers(with: User) {
        (profile.viewControllers.first as? ProfileController)?.user = user
    }
    
    private func configureLoginViewController() {
        let isLoggedIn: Bool = AuthUseCase.checkLoggedIn()
        if isLoggedIn == false {
            let controller = LoginController()
            controller.delegate = self
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension MainTabController: AuthenticationDelegate {
    private func fetchUser() {
        UserService.fetchUser().then { user in
            self.user = user
        }
    }
    func didAuthenticationComplete() {
        print("DEBUG: Auth did complete. Fetch user and update here...")
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
