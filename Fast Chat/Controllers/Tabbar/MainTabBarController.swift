//
//  TabBarController.swift
//  Fast Chat
//
//  Created by Macbook on 12/6/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()
        
        UITabBar.appearance().backgroundColor = Colors.gold
        //tabBar.backgroundImage = UIImage(systemName: "person")
        //self.tabBar.barTintColor = .yellow
        self.tabBar.tintColor = .green
        self.tabBar.unselectedItemTintColor = .purple
    }


    private func configureTabbar() {
        
        let userVC = self.createNav(with: "Users", and: UIImage(systemName: "car"), vs: UsersViewController())
        let chatVC = self.createNav(with: "Chats", and: UIImage(systemName: "bell"), vs: ChatsViewController())

        self.setViewControllers([userVC, chatVC], animated: true)
    }
    
    // MARK: CREATE NAV BAR
    
    private func createNav(with title: String, and image: UIImage?, vs: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vs)
        nav.navigationItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Button", style: .done, target: nil, action: nil)
        return nav
    }
    
}
