//
//  GamesCollectionView.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit
class GamesCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ViewModelDelegate {
    
    var gamesViewModel: GamesViewModel
    
    init(gamesViewModel: GamesViewModel) {
        self.gamesViewModel = gamesViewModel
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setupUI()
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        self.gamesViewModel = GamesViewModel(delegate: nil)
        super.init(coder: coder)
        gamesViewModel.delegate = self
        setupUI()
        setupViewModel()
    }
    
    func setupViewModel() {
        gamesViewModel = GamesViewModel(delegate: self)
        gamesViewModel.fetchData()
    }
    
    func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .seenItemUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .favoritedItemUpdated, object: nil)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingMoreCollectionViewCell", for: indexPath) as! LoadingMoreCollectionViewCell            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
            let cellViewModel = gamesViewModel.cellViewModelForIndex(index: indexPath.row)
            
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
        let cellViewModel = gamesViewModel.cellViewModelForIndex(index: indexPath.row)
        cellViewModel.markAsSeen()
    }
}

// MARK: - View Model Delegate
extension GamesCollectionView {
    func viewModelDidFetchData(loadMore: Bool) {
        self.reloadData()
    }
    
    func viewModelFetchFailed(errorMessage: String) {
        //handle error
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
        if gamesViewModel.loadMore && indexPath.row == gamesViewModel.itemsCount() {
            return true
        }
        
        return false
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
