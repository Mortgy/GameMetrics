//
//  GameDetailsViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/21/21.
//

import UIKit

class GameDetailsViewModel {

    var game: GameModel
    var gameDetails: GameDetailsModel?
    var gameDetailRequest: GameDetailsRequest?
    var isLoading: Bool = true
    var delegate: ViewModelDelegate?

    init(game: GameModel) {
        self.game = game
        gameDetailRequest = GameDetailsRequest(id: self.game.id)
    }
    
    func fetchData() {
        let endpoint = APIEndpoints.getGame(with: gameDetailRequest!)
        DIContainer.shared.apiDataTransferService.request(with: endpoint) { [weak self] result in
            guard case let .success(response) = result else { return }
            self?.gameDetails = response
            self?.isLoading = false
            self?.delegate?.viewModelDidFetchData(loadMore: false)
        }
    }
}
