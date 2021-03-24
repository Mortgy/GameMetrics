//
//  SafariHandler.swift
//  GameMetrics
//
//  Created by Mortgy on 3/24/21.
//

import Foundation
import UIKit
import SafariServices

protocol SafariOpenURL {
    func openURL(targetURL: URL)
}

extension SafariOpenURL where Self: UIViewController {
    func openURL(targetURL: URL) {
        guard presentedViewController == nil else { return }
        
        let safariViewController = SFSafariViewController(url: targetURL, configuration: SFSafariViewController.Configuration())
        safariViewController.modalTransitionStyle = .coverVertical
        safariViewController.definesPresentationContext = true
        
        present(safariViewController, animated: true)
    }
    
}
