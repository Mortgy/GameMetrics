//
//  GamesViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

class HomeViewController: UIViewController, Alert {
    
    @IBOutlet weak var gamesCollectionView: GamesCollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    var gamesViewModel: HomeViewModel
    
    init(gamesViewModel: HomeViewModel) {
        self.gamesViewModel = gamesViewModel
        
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
        title = "Games"
        setupCollectionViewModel()
    }
    
    
}

extension HomeViewController {
    func setupCollectionViewModel() {
        self.gamesViewModel.delegate = gamesCollectionView
        gamesCollectionView.setupView(gamesViewModel: gamesViewModel)
    }
}

// MARK: - Screen Rotation
extension HomeViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        gamesCollectionView?.collectionViewLayout.invalidateLayout()
        gamesCollectionView?.layoutMargins = .zero
        gamesCollectionView?.reloadData()
    }
}

// MARK: - SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count > 3 {
            activityIndicator.isHidden = true
            infoLabel.isHidden = true
            
            pendingRequestWorkItem?.cancel()
            
            let requestWorkItem = DispatchWorkItem { [weak self] in
                self?.gamesViewModel.search(keyword: searchBar.text!)
            }
            
            // Save the new work item and execute it after 250 ms
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750),
                                          execute: requestWorkItem)
        } else if let text = searchBar.text, text.count > 0 && text.count <= 3 {
            pendingRequestWorkItem?.cancel()
            gamesViewModel.reset()
            gamesCollectionView.reloadData()
            activityIndicator.isHidden = false
            infoLabel.isHidden = false
        } else {
            pendingRequestWorkItem?.cancel()
            gamesViewModel.reset()
            gamesViewModel.fetchData()
            activityIndicator.isHidden = true
            infoLabel.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        gamesViewModel.reset()
        gamesViewModel.fetchData()
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
