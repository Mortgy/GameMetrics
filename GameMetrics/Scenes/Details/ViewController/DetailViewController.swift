//
//  DetailViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit

class DetailViewController: UIViewController, DetailsViewModelDelegate {

    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    
    var favoriteButton: UIBarButtonItem?
    
    weak var coordinator: MainCoordinator?
    var detailViewModel: DetailsViewModel
    var game: GameModel
    
    init(detailViewModel: DetailsViewModel, game: GameModel) {
        self.detailViewModel = detailViewModel
        self.game = game
        super.init(nibName: nil, bundle: nil)
        self.detailViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        favoriteButton = UIBarButtonItem(title: detailViewModel.favoriteButtonTitle, style: .plain, target: self, action: #selector(toggleFavoriteAction))
        self.navigationItem.rightBarButtonItem = favoriteButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setupUI()
        self.detailViewModel.fetchData()
    }
}

//MARK: - UIActions
extension DetailViewController {
    @objc func toggleFavoriteAction(_ sender: UIBarButtonItem) {
        detailViewModel.toggleFavorite()
    }
    
    @IBAction func showMoreAction(_ sender: UIButton) {
        if gameDescriptionLabel.numberOfLines == 0 {
            gameDescriptionLabel.numberOfLines = 4
            sender.setTitle("read more", for: .normal)

        } else {
            gameDescriptionLabel.numberOfLines = 0
            sender.setTitle("less", for: .normal)
        }
    }
}

extension DetailViewController {
    func favoriteUpdated() {
        favoriteButton?.title = detailViewModel.favoriteButtonTitle
    }
    
    func viewModelDidFetchData(loadMore: Bool) {
        setupUI()
    }
    
    func viewModelFetchFailed(errorMessage: String) {
        
    }
}

extension DetailViewController {
    func setupUI() {
        gameTitleLabel.text = detailViewModel.name
        
        if let imageUrl = detailViewModel.imageURL {
            gameImageView.load(url: imageUrl)
        } else {
            gameImageView.image = UIImage(named: "placeholder")
        }
        
        gameDescriptionLabel.text = detailViewModel.descripton
    }
}
