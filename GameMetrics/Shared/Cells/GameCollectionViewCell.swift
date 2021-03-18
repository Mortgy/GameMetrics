//
//  GameCollectionViewCell.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
