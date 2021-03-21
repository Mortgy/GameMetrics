//
//  ViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

protocol ViewModel {

    var delegate: ViewModelDelegate? { set get }
    func fetchData ()
    func itemsCount() -> Int
    func itemAtIndex<T>(index: Int) -> T
    
}

protocol ViewModelDelegate: class {
    
    func viewModelDidFetchData(loadMore: Bool)
    func viewModelFetchFailed(errorMessage: String)

}
