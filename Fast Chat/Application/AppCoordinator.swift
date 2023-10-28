//
//  AppCoordinator.swift
//  Fast Chat
//
//  Created by Macbook on 25/10/23.
//

import UIKit

final class AppCoordinator {
    
    private(set) var window: UIWindow?
    
    private lazy var tabBarController = UITabBarController()
    private var navigationControllers = AppCoordinator.makeNavControllers()
    
    init(window: UIWindow? = nil) {
        self.window = window
        self.setupAppearance()
        
    }
    
    func start() {
        
        self.setupUserListVC()
        self.setupSearchVC()
        self.setupSettingsVC()
        
        let navControllers = NavControllerType.allCases.compactMap {
            self .navigationControllers[$0] }
        
        self.tabBarController.setViewControllers(navControllers, animated: true)
        
        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    static private func makeNavControllers() -> [NavControllerType: UINavigationController] {
        
        var result = [NavControllerType: UINavigationController]()
        
        NavControllerType.allCases.forEach { navControllerKey in
            
            let navigationControlller = UINavigationController()
            let tabbarItem = UITabBarItem(title: navControllerKey.title , image: navControllerKey.image, selectedImage: navControllerKey.selectedImage)
            
            navigationControlller.tabBarItem = tabbarItem
            navigationControlller.navigationBar.prefersLargeTitles = true
            
            result[navControllerKey] = navigationControlller
        }
        
        return result
    }
    
    private func setupUserListVC() {
        guard let navController = self.navigationControllers[.userList] else {
            fatalError("can't find navController")
        }
        let viewController = UsersViewController()
        navController.setViewControllers([viewController], animated: false)
        navController.view.backgroundColor = .systemBackground
        navController.navigationItem.title = NavControllerType.userList.title
        
    }
    
    private func setupSearchVC() {
        guard let navController = self.navigationControllers[.search] else {
            fatalError("can't find navController")
        }
        let viewController = SearchViewController()
        navController.setViewControllers([viewController], animated: false)
        navController.view.backgroundColor = .systemBackground
        navController.navigationItem.title = NavControllerType.search.title
    }
    
    private func setupSettingsVC() {
        guard let navController = self.navigationControllers[.settings] else {
            fatalError("can't find navController")
        }
        let viewController = SettingsViewController()
        navController.setViewControllers([viewController], animated: false)
        navController.view.backgroundColor = .systemBackground
        navController.navigationItem.title = NavControllerType.settings.title
    }
}


extension AppCoordinator {
    
    private enum NavControllerType: Int, CaseIterable {
        case userList
        case search
        case settings
        
        
        var title: String {
            switch self {
            case .userList:
                return Helpers.Localization.userList
            case .search:
                return Helpers.Localization.search
            case .settings:
                return Helpers.Localization.settings
            }
        }
        
        var image: UIImage? {
            switch self {
            case .userList:
                return Helpers.Image.userList
            case .search:
                return Helpers.Image.search
            case .settings:
                return Helpers.Image.settings
            }
        }
        
        var selectedImage: UIImage? {
            switch self {
            case .userList:
                return Helpers.Image.userListSelected
            case .search:
                return Helpers.Image.searchSelected
            case .settings:
                return Helpers.Image.settingsSelected
            }
        }
    }
}

extension AppCoordinator {
    
    private func setupAppearance() {
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            
            
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
        
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = Helpers.Styles.Colors.purple
        UITabBar.appearance().backgroundColor = .systemBackground
    }
}


