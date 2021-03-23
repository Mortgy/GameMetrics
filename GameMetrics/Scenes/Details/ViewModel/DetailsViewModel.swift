//
//  DetailsViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/21/21.
//

import UIKit

protocol DetailsViewModelDelegate {
    func viewModelDidFetchData(loadMore: Bool)
    func viewModelFetchFailed(errorMessage: String)
    func favoriteUpdated()
}

class DetailsViewModel {
    
    var game: GameModel
    var apiServices: ApiServices
    var gameDetails: GameDetailsModel?
    var gameDetailRequest: GameDetailsRequest?
    var isLoading: Bool = true
    var delegate: DetailsViewModelDelegate?
    
    init(game: GameModel, apiServices: ApiServices) {
        self.game = game
        self.apiServices = apiServices
        gameDetailRequest = GameDetailsRequest(id: self.game.id)
    }
    
    func fetchData() {
        
        _ = apiServices.getGameDetails(gameDetailRequest: gameDetailRequest!) { [weak self] result in
            self?.gameDetails = result
            self?.isLoading = false
            self?.delegate?.viewModelDidFetchData(loadMore: false)
        } fail: { [weak self] errorMessage in
            self?.delegate?.viewModelFetchFailed(errorMessage: errorMessage)
        }
    }
    
}

// MARK: - Game Details
extension DetailsViewModel {
    var name: String? {
        gameDetails?.name ?? game.name ?? ""
    }
    
    var imageURL: URL? {
        URL(string: gameDetails?.backgroundImage ?? game.backgroundImage ?? "")
    }
    
    var descripton: String? {
        gameDetails?.gameDetailsModelDescription?.withoutHtml
    }
    
    var redditURL: URL? {
        URL(string: gameDetails?.redditUrl ?? "")
    }
    
    var websiteURL: URL? {
        URL(string: gameDetails?.website ?? "")
    }
    
    var favoriteButtonTitle: String {
        return isFavorited() ? "Unfavorite" : "Favorite"
    }
    
}

// MARK: - Favorite Management
extension DetailsViewModel {
    
    func isFavorited() -> Bool {
        return MemoryCacheManager.shared.valueExists(value: "\(game.id)", in: .favoriteGames)
    }
    
    func toggleFavorite() {
        if isFavorited() {
            MemoryCacheManager.shared.pop(value: "\(game.id)", forList: .favoriteGames)
            
            DiskCacheManager.shared.remove("\(game.id)", from: .favoriteGames)
            DiskCacheManager.shared.remove(gameDetails!.detailCacheId, from: .favoriteGameDetails)
        } else {
            MemoryCacheManager.shared.append(value: "\(game.id)", forList: .favoriteGames)
            
            DiskCacheManager.shared.add(game, for: "\(game.id)", to: .favoriteGames)
            DiskCacheManager.shared.add(gameDetails, for: gameDetails!.detailCacheId, to: .favoriteGameDetails)
        }
        
        delegate?.favoriteUpdated()
        NotificationCenter.default.post(name: .favoritedItemUpdated, object: nil)
        
    }
    
}
