//
//  Alert.swift
//  GameMetrics
//
//  Created by Mortgy on 3/23/21.
//

import Foundation
import UIKit

protocol Alert {
    func showAlert(from: (UIViewController & Alert), title: String, message: String, actions: [UIAlertAction]?)
}

extension Alert {
    func showAlert(from: (UIViewController & Alert), title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard from.presentedViewController  == nil else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
          alertController.addAction(action)
        }
        
        from.present(alertController, animated: true)
    }
}
