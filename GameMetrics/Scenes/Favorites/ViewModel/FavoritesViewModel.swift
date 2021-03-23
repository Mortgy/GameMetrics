//
//  GamesViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit

class FavoritesViewModel: GamesCollectionViewModel {
    internal var fetchedData = [GameModel]()
    internal var loadMore: Bool = false
    var coordinator: GameCoordinator
    var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate? = nil, coordinator: GameCoordinator) {
        self.coordinator = coordinator
        self.delegate = delegate
    }
    
    func fetchData () {
        fetchedData = DiskCacheManager.shared.values(in: .favoriteGames)
        delegate?.viewModelDidFetchData(loadMore: self.loadMore)
    }
    
    func itemsCount() -> Int {
        return loadMore ? (fetchedData.count + 1) : fetchedData.count
    }
    
    func itemAtIndex<T>(index: Int) -> T {
        return fetchedData[index] as! T
    }
    
    func cellViewModelForIndex<T>(index: Int) -> T {
        return GameCellViewModel(game: fetchedData[index]) as! T
    }
    
    func search(keyword: String) {
    }
    
    func reset() {
    }
}
