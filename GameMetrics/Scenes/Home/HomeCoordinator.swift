//
//  FavoritesCoordinator.swift
//  GameMetrics
//
//  Created by Mortgy on 3/22/21.
//

import Foundation
import UIKit

class HomeCoordinator: GameCoordinator {
    
    override func start() {
        let homeViewModel = HomeViewModel(coordinator: self)
        let homeViewController = HomeViewController(gamesViewModel: homeViewModel)
        homeViewController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "gamePad"), tag: 0)
        navigationController = UINavigationController(rootViewController:homeViewController)
    }
}
