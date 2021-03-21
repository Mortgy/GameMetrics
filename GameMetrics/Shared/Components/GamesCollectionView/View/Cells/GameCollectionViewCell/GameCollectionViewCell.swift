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
    @IBOutlet weak var gameGenresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with viewModel: GameCellViewModel) {
        gameImageView.load(url: viewModel.imageURL!)
        gameTitleLabel.text = viewModel.name
        gameScoreLabel.text = viewModel.metacritic
        gameGenresLabel.text = viewModel.genres
        
        if viewModel.seen == true {
            backgroundColor = UIColor(named: "dark white")
        } else {
            backgroundColor = UIColor(named: "visited_gray")
        }
    }
}
