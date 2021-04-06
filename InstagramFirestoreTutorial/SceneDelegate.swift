//
//  SceneDelegate.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = MainTabController()
        window?.rootViewController = UINavigationController(rootViewController: LoginController())
        // Shows the window and makes it the key window.
        window?.makeKeyAndVisible()
    }

}

