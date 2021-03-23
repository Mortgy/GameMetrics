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
    
    internal var fetchedData = [GameModel]()
    internal var gamesRequest: GamesRequest = GamesRequest(search: nil)
    internal var loadMore: Bool = false
    var networkRequest: NetworkCancellable?
    var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate? = nil, coordinator: GameCoordinator) {
        self.delegate = delegate
        self.coordinator = coordinator
    }
    
    func search (keyword: String) {
        networkRequest?.cancel()
        loadMore = false
        gamesRequest = GamesRequest(search: keyword)
        fetchedData = [GameModel]()
        fetchData()
    }
    
    func resetNoFetch () {
        loadMore = false
        gamesRequest = GamesRequest(search: nil)
        fetchedData = [GameModel]()
    }
    
    func reset () {
        loadMore = false
        gamesRequest = GamesRequest(search: nil)
        fetchedData = [GameModel]()
        fetchData()
    }
    
    func fetchData () {
        gamesRequest.addPage()
        let endpoint = APIEndpoints.getGames(with: gamesRequest)
        let cacheName = (endpoint.path + "\(gamesRequest.page)").MD5()

        DispatchQueue.global(qos: .background).async { [weak self] in

            if self?.offlineFirst(cacheName: cacheName) == false  {
                self?.networkRequest = DIContainer.shared.apiDataTransferService.request(with: endpoint) { [weak self] result in
                    
                    guard case let .success(response) = result, let games = response.results else { return }
                    
                    self?.fetchedData.append(contentsOf: games)
                    self?.loadMore = response.next != nil ? true : false
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.viewModelDidFetchData(loadMore: self!.loadMore)
                    }
                    
                    self?.isSearching() == false ? DiskCacheManager.shared.add(response, for: cacheName, to: .backend) : nil
                }
            }
        }
        
    }
    
    func offlineFirst(cacheName: String) -> Bool {
        if  DiskCacheManager.shared.valueExists(cacheName, in: .backend){
            guard isSearching() == false, let response: GameResponseModel = DiskCacheManager.shared.value(cacheName, from: .backend) else {
                return false
            }
            fetchedData.append(contentsOf: response.results!)
            loadMore = response.next != nil ? true : false
            
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.viewModelDidFetchData(loadMore: self!.loadMore)
            }
            
            return true
        }
        
        return false

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
