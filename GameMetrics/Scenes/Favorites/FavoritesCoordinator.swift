//
//  FavoritesCoordinator.swift
//  GameMetrics
//
//  Created by Mortgy on 3/22/21.
//

import Foundation
import UIKit

class FavoritesCoordinator: GameCoordinator {
    
    override func start() {
        let favoritesViewModel = FavoritesViewModel(coordinator: self)
        let favoritesViewController = FavoritesViewController(favoritesViewModel: favoritesViewModel)
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController = UINavigationController(rootViewController:favoritesViewController)
    }
}
