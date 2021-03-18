//
//  GradientView.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit

class GradientView: UIView {

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        return layer
    }()
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(gradientLayer)
    }
    

}
