//
//  TabBarController.swift
//  Fast Chat
//
//  Created by Macbook on 12/6/23.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()
        
        UITabBar.appearance().backgroundColor = Colors.gold
        //tabBar.backgroundImage = UIImage(systemName: "person")
        //self.tabBar.barTintColor = .yellow
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .systemGray
        
        //self.tabBar.barTintColor = .black
        //  self.navigationItem.setHidesBackButton(true, animated: true)
        //
        self.navigationController?.isNavigationBarHidden = true
        self.delegate = self
        
        UINavigationBar.appearance().barTintColor = Colors.gold
        UINavigationBar.appearance().tintColor = Colors.gold
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    
    
    private func configureTabbar() {
        
        let userVC = self.createNav(with: "Users", and: UIImage(systemName: "person"), vs: UsersViewController())
        let chatVC = self.createNav(with: "Chats", and: UIImage(systemName: "message"), vs: MessageListController())
        
        self.setViewControllers([userVC, chatVC], animated: true)
    }
    
    // MARK: CREATE NAV BAR
    
    private func createNav(with title: String, and image: UIImage?, vs: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vs)
        nav.navigationItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title// + " Controller"
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .done, target: self, action: #selector(goToRootVc(sender:)))
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Button", style: .done, target: nil, action: nil)
        
        
        
        nav.tabBarItem.title = title
        return nav
    }
    
    @objc private func goToRootVc(sender: UIButton) {
        print("Tabbar right button tapped 1 vs")
        navigationController?.pushViewController(StartViewController(), animated: true)
    }
    //    override func willMove(toParent parent: UIViewController?) {
    //        navigationController?.navigationBar.barTintColor = UIColor.black
    //        navigationController?.navigationBar.tintColor = UIColor.black
    //    }
    
}
