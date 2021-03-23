//
//  MainCoordinator.swift
//  GameMetrics
//
//  Created by Mortgy on 3/22/21.
//

import Foundation
import UIKit

protocol CoordinatorChild {
    var coordinator: MainCoordinator? { get set }
}

class MainCoordinator: Coordinator {
    
    var children = [Coordinator]()

    var navigationController: UINavigationController?
    var tabBarViewController: UITabBarController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    init(tabBarViewController: UITabBarController) {
        self.tabBarViewController = tabBarViewController
    }
    
    func start() {
        if let tabBarVC = tabBarViewController {
            
            let gameCoordinator = HomeCoordinator()
            gameCoordinator.start()
            
            let favoritesCoordinator = FavoritesCoordinator()
            favoritesCoordinator.start()
            
            children.append(gameCoordinator)
            children.append(favoritesCoordinator)

            tabBarVC.viewControllers = children.map { $0.navigationController! }
        }
    }
    
    
    
}
