//
//  SceneDelegate.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var userDefaults = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
      //  userDefaults.set(false, forKey: "isLogin")
        let isLogin = userDefaults.object(forKey: "isLogin") as? Bool ?? false
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if isLogin {
            startTabbar()
        } else {
            startLogin()
        }
    }

    func startTabbar() {
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
    }
    
    func startLogin() {
        self.window?.rootViewController = UINavigationController(rootViewController: StartViewController())
        self.window?.makeKeyAndVisible()
    }
    
}

