//
//  AppDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    let navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: screenBounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        // Setup Coordinator
        mainCoordinator = MainCoordinator(rootNavigationController: navController)
        mainCoordinator!.start()

        return true
    }
}
