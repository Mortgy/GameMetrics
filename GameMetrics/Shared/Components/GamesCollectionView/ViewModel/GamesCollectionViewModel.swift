//
//  ViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

protocol GamesCollectionViewModel {
    var delegate: ViewModelDelegate? { set get }
    var loadMore: Bool { set get }
    var coordinator: GameCoordinator { get set }
    func fetchData ()
    func itemsCount() -> Int
    func itemAtIndex<T>(index: Int) -> T
    func cellViewModelForIndex<T>(index: Int) -> T
    func search (keyword: String)
    func reset ()
}

protocol ViewModelDelegate: class {
    
    func viewModelDidFetchData(loadMore: Bool)
    func viewModelFetchFailed(errorMessage: String)

}
