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
    }
}

