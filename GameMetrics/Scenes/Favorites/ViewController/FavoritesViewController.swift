//
//  FavoritesViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    weak var coordinator: FavoritesCoordinator?

    @IBOutlet weak var favoritesCollectionView: GamesCollectionView!
    var favoritesViewModel: FavoritesViewModel

    init(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Favorites"
        setupCollectionViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesCollectionView.gamesViewModel.fetchData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController {
    func setupCollectionViewModel() {
        favoritesViewModel.delegate = favoritesCollectionView
        favoritesCollectionView.setupView(gamesViewModel: favoritesViewModel)
    }
}

// MARK: - Screen Rotation
extension FavoritesViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        favoritesCollectionView?.collectionViewLayout.invalidateLayout()
        favoritesCollectionView?.layoutMargins = .zero
        favoritesCollectionView?.reloadData()
    }
}
