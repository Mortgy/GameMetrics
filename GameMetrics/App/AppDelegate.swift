//
//  AppDelegate.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        coordinator = MainCoordinator(tabBarViewController: tabBarController)
        coordinator?.start()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

