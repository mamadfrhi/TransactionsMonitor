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
    
    private var rootNavigationController = UINavigationController()
    
    // MARK: Coordinator
    init(window: UIWindow?) { self.window = window }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        // show Main.storyboard as the start point of the app
        let mainCoordinator = MainCoordinator(rootNavigationController: rootNavigationController)
        mainCoordinator.start()
    }
}

