//
//  InitialViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

class InitialViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewControllers = createTabBarViewControllers()
    }
    
    func createTabBarViewControllers() -> [UIViewController] {
        let gamesViewController = GamesViewController()
        gamesViewController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "gamePad"), tag: 0)
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllers = [gamesViewController, favoritesViewController]
        return viewControllers.map { UINavigationController(rootViewController: $0) }
    }


}

