//
//  ViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

protocol GamesCollectionViewModel {
    var delegate: GamesCollectionViewModelDelegate? { set get }
    func fetchData ()
    func itemsCount() -> Int
    func itemAtIndex<T>(index: Int) -> T
    func cellViewModelForIndex<T>(index: Int) -> T
    var loadMore: Bool { set get }

}

protocol GamesCollectionViewModelDelegate: class {
    
    func viewModelDidFetchData(loadMore: Bool)
    func viewModelFetchFailed(errorMessage: String)

}
