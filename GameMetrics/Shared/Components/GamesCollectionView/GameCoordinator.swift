//
//  GameCoordinator.swift
//  GameMetrics
//
//  Created by Mortgy on 3/22/21.
//

import Foundation
import UIKit

class GameCoordinator: Coordinator {
    
    var children =  [Coordinator]()
    var navigationController: UINavigationController?
    var tabBarViewController: UITabBarController?
    
    func start() {
        let homeViewModel = HomeViewModel(coordinator: self)
        let homeViewController = HomeViewController(gamesViewModel: homeViewModel)
        homeViewController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "gamePad"), tag: 0)
        navigationController = UINavigationController(rootViewController:homeViewController)
    }
    
    func pushGameDetail(game: GameModel) {
        let detailViewModel = GameDetailsViewModel(game: game)
        
        let detailViewController = DetailViewController(detailViewModel: detailViewModel, game: game)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
