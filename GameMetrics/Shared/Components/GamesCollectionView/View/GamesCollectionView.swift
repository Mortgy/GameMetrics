//
//  GamesCollectionView.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit
class GamesCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ViewModelDelegate {
    
    var gamesViewModel: GamesCollectionViewModel!
    
    func setupView(gamesViewModel: GamesCollectionViewModel) {
        self.gamesViewModel = gamesViewModel
        
        setupUI()
        setupViewModel()
        registerObservers()
    }
    
    func setupViewModel() {
        self.gamesViewModel.delegate = self
        gamesViewModel.fetchData()
    }
    
    func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .seenItemUpdated, object: nil)
    }
}

// MARK: - Setup UI
extension GamesCollectionView {
    
    func setupUI() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameCell")
        register(UINib(nibName: "LoadingMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadMoreCell")
        dataSource = self
        delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource
extension GamesCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamesViewModel.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if showLoadMoreCell(for: indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadMoreCell", for: indexPath) as! LoadingMoreCollectionViewCell            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
            let cellViewModel: GameCellViewModel = gamesViewModel.cellViewModelForIndex(index: indexPath.row)
            
            cell.setup(with: cellViewModel)
            
            return cell
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension GamesCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if showLoadMoreCell(for: indexPath) {
            gamesViewModel.fetchData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellViewModel: GameCellViewModel = gamesViewModel.cellViewModelForIndex(index: indexPath.row)
        cellViewModel.markAsSeen()
        let game: GameModel = gamesViewModel.itemAtIndex(index: indexPath.row)
        gamesViewModel.coordinator.pushGameDetail(game: game)
    }
}

// MARK: - View Model Delegate
extension GamesCollectionView {
    func viewModelDidFetchData(loadMore: Bool) {
        self.reloadData()
    }
    
    func viewModelFetchFailed(errorMessage: String) {
        //handle error
        gamesViewModel.coordinator.showAlert(title: "Network Error", message: errorMessage)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GamesCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if showLoadMoreCell(for: indexPath) {
            return CGSize(width: collectionView.frame.width, height: 100)
        }
        
        return itemSize()
    }
    
}

// MARK: - Helpers
extension GamesCollectionView {
    func itemSize() -> CGSize {
        var itemWidth: CGFloat!
        var itemHeight: CGFloat!
        if deviceType() == .pad {
            if deviceOrientation().isLandscape {
                itemWidth = self.frame.width / 3
                itemHeight = calculateItemHeight(itemWidth: itemWidth)
                return CGSize(width: itemWidth, height: itemHeight)
            }
            
            itemWidth = self.frame.width / 2
            itemHeight = calculateItemHeight(itemWidth: itemWidth)
            return CGSize(width: itemWidth, height: itemHeight)
            
        } else {
            
            if deviceOrientation().isLandscape {
                itemWidth = self.frame.width / 2
                itemHeight = calculateItemHeight(itemWidth: itemWidth)
                return CGSize(width: itemWidth, height: itemHeight)
            }
            
            itemWidth = self.frame.width
            itemHeight = calculateItemHeight(itemWidth: itemWidth)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func showLoadMoreCell(for indexPath: IndexPath) -> Bool {
        guard gamesViewModel.loadMore else { return false }
        return indexPath.row == ( gamesViewModel.itemsCount() - 1 )
    }
    
    func calculateItemHeight(itemWidth: CGFloat) -> CGFloat {
        return 136 * (itemWidth/375)
    }
    
    func deviceType() -> UIUserInterfaceIdiom {
        return UIDevice().userInterfaceIdiom
    }
    
    func deviceOrientation() -> UIInterfaceOrientation{
        UIApplication.shared.statusBarOrientation
    }
}
