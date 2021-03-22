//
//  GamesViewController.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: GamesCollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    var gamesViewModel: HomeViewModel?
    
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
        gamesViewModel = HomeViewModel(delegate: gamesCollectionView)
        gamesCollectionView.setupView(gamesViewModel: gamesViewModel!)
    }
}

extension HomeViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count > 3 {
            activityIndicator.isHidden = true
            infoLabel.isHidden = true
            
            pendingRequestWorkItem?.cancel()
            
            let requestWorkItem = DispatchWorkItem { [weak self] in
                self?.gamesViewModel!.search(keyword: searchBar.text!)
            }
            
            // Save the new work item and execute it after 250 ms
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                          execute: requestWorkItem)
        } else if let text = searchBar.text, text.count > 0 && text.count <= 3 {
            pendingRequestWorkItem?.cancel()
            gamesViewModel?.resetNoFetch()
            gamesCollectionView.reloadData()
            activityIndicator.isHidden = false
            infoLabel.isHidden = false
        } else {
            pendingRequestWorkItem?.cancel()
            gamesViewModel?.reset()
            activityIndicator.isHidden = true
            infoLabel.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        gamesViewModel?.reset()
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
