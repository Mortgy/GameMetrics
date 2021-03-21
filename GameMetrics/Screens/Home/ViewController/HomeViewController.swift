//
//  GamesViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: GamesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Games"
        setupCollectionViewModel()
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

extension HomeViewController {
    func setupCollectionViewModel() {
        let gamesViewModel = GamesViewModel(delegate: gamesCollectionView)
        gamesCollectionView.setupView(gamesViewModel: gamesViewModel)
    }
}
