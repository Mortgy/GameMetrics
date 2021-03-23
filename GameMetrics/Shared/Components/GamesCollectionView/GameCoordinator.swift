//
//  GameCoordinator.swift
//  GameMetrics
//
//  Created by Mortgy on 3/22/21.
//

import Foundation
import UIKit

class GameCoordinator: Coordinator, Alert {
    
    var children =  [Coordinator]()
    var navigationController: UINavigationController?
    var tabBarViewController: UITabBarController?
    
    func start() {
        
    }
    
    func pushGameDetail(game: GameModel) {
        let apiServices = ApiServices()
        let detailViewModel = DetailsViewModel(game: game, apiServices: apiServices)
        
        let detailViewController = DetailViewController(detailViewModel: detailViewModel, game: game)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        var actions = [UIAlertAction]()
        let action = UIAlertAction(title: "OK", style: .cancel)
        actions.append(action)
        
        showAlert(from: navigationController?.children.last as! (UIViewController & Alert), title: title, message: message, actions: actions)
    }
    
}
