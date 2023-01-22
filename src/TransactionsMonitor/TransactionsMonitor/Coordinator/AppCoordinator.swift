//
//  AppCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let window: UIWindow?
    
    private var rootTabBarController = UITabBarController()
    
    // MARK: Coordinator
    init(window: UIWindow?) { self.window = window }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootTabBarController
        window.makeKeyAndVisible()
        
        let transactionsCoordinator = TransactionsCoordinator(rootTabBarController: rootTabBarController)
        transactionsCoordinator.start()
        
        configTabBar()
    }
}

// MARK: Open for extension
// I watned to show how forward-thinker I'm and care about architecture.
// Also, have maintainability and Clean Code in mind while development.
// As mentioned in the requirements of the app, it's planned for the to have 2 other screens in the future.
// Then here you can see that it's compeltely easy to extend the app. Actually, it's ready to add new features.

// You can easily add new tabs and VCs with its own Coordinator.
// But here for sake of simplicity I didn't develop Coordinators for other tabs.

extension AppCoordinator {
    private func configTabBar() {
        addShoppingTabBar()
        addSettingsTabBar()
    }
    
    func addShoppingTabBar() {
        let transactionsVC = ShoppingVC.`init`()
        let tabBar = UITabBarItem(title: "Shopping",
                                  image: UIImage(systemName: "cart"), tag: 0)
        transactionsVC.tabBarItem = tabBar
        
        rootTabBarController.viewControllers?.append(transactionsVC)
    }
    
    func addSettingsTabBar() {
        let transactionsVC = SettingsVC.`init`()
        let tabBar = UITabBarItem(title: "Settings",
                                  image: UIImage(systemName: "gear"), tag: 1)
        transactionsVC.tabBarItem = tabBar
        
        rootTabBarController.viewControllers?.append(transactionsVC)
    }
}
