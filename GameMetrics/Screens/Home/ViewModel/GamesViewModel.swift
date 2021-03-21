//
//  GamesViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import UIKit

class GamesViewModel: GamesCollectionViewModel, GamesRequestProtocol {
    
    internal var fetchedData = [GameModel]()
    internal var gamesRequest: GamesRequest = GamesRequest(search: nil)
    internal var loadMore: Bool = false

    var delegate: GamesCollectionViewModelDelegate?
    
    init(delegate: GamesCollectionViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func fetchData () {
        gamesRequest.addPage()
        let endpoint = APIEndpoints.getGames(with: gamesRequest)
        
        DIContainer.shared.apiDataTransferService.request(with: endpoint) { result in
            
            guard case let .success(response) = result, let games = response.results else { return }
            self.fetchedData.append(contentsOf: games)
            self.loadMore = response.next != nil ? true : false
            self.delegate?.viewModelDidFetchData(loadMore: self.loadMore)
            
        }
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
