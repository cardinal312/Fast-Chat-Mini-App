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
        self.view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: UsersViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: SettingsViewController())
        
        vc1.tabBarItem.image = Helpers.Image.userList
        vc1.tabBarItem.selectedImage = Helpers.Image.userListSelected
        vc1.tabBarItem.title = Helpers.Localization.userList
        
        vc2.tabBarItem.image = Helpers.Image.search
        vc2.tabBarItem.selectedImage = Helpers.Image.searchSelected
        vc2.tabBarItem.title = Helpers.Localization.search
        
        vc3.tabBarItem.image = Helpers.Image.settings
        vc3.tabBarItem.selectedImage = Helpers.Image.settingsSelected
        vc3.tabBarItem.title = Helpers.Localization.settings
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}
