//
//  GamesViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit

class FavoritesViewModel: GamesCollectionViewModel {
    func search(keyword: String) {
    }
    
    func reset() {
    }
    
    
    internal var fetchedData = [GameModel]()
    internal var loadMore: Bool = false

    var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func fetchData () {
        fetchedData = DiskCacheManager().values(in: .favoriteGames)
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
}
