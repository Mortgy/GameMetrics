//
//  GamesViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit
import SENetworking

class HomeViewModel: GamesCollectionViewModel, GamesRequestProtocol {
    var coordinator: GameCoordinator
    var apiServices: ApiServices
    
    internal var fetchedData = [GameModel]()
    internal var gamesRequest: GamesRequest = GamesRequest(search: nil)
    internal var loadMore: Bool = false
    var networkRequest: NetworkCancellable?
    var delegate: ViewModelDelegate?
    
    init(coordinator: GameCoordinator, apiServices: ApiServices) {
        self.coordinator = coordinator
        self.apiServices = apiServices
    }
    
    func search (keyword: String) {
        networkRequest?.cancel()
        loadMore = false
        gamesRequest = GamesRequest(search: keyword)
        fetchedData = [GameModel]()
        fetchData()
    }
    
    func reset () {
        loadMore = false
        gamesRequest = GamesRequest(search: nil)
        fetchedData = [GameModel]()
    }
    
    func fetchData () {
        gamesRequest.addPage()
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            let loadFromCache = (self?.fetchedData.isEmpty ?? true) && (self?.isSearching() == false) && (self?.gamesRequest.page == 1)
            let request = self?.apiServices.getGames(gamesRequest: self!.gamesRequest, from: loadFromCache) { [weak self] result in
                guard let games = result.results else {
                    
                    self?.delegate?.viewModelFetchFailed(errorMessage: "Failed to fetch data")
                    return
                }
                
                
                loadFromCache ? self?.fetchedData.removeAll() :
                    
                self?.fetchedData.append(contentsOf: games)
                self?.loadMore = result.next != nil ? true : false
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.viewModelDidFetchData(loadMore: self!.loadMore)
                }
                
            } fail: { errorMessage in
                self?.delegate?.viewModelFetchFailed(errorMessage: errorMessage)
            }
            
            self?.networkRequest = request?.0
            
            if let tempCache = request?.1 {
                self?.fetchedData.append(contentsOf: tempCache.results!)
                self?.loadMore = tempCache.next != nil ? true : false
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.viewModelDidFetchData(loadMore: self!.loadMore)
                }
            }
            
        }
        
    }
    
    func isSearching() -> Bool {
        if gamesRequest.search != nil {
            return true
        }
        return false
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
