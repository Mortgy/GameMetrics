//
//  GameCollectionViewCell.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit
import SDWebImage

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
        
        gameImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: nil, options: .waitStoreCache) { [weak self] (image, error, cacheType, url) in
            
            UIView.animate(withDuration: 0.3) {
                self?.gameImageView.alpha = 1
            }

        }
        
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
