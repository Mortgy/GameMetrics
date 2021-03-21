//
//  GameSearchEndpoint.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import Foundation
import SENetworking

struct APIEndpoints : APIEndpointsProtocol {
    
}

protocol APIEndpointsProtocol {
    static func getGames(with GameRequestDTO: GamesRequest) -> Endpoint<GameResponseModel>
    static func getGame(with GameDetailRequestDTO: GameDetailsRequest) -> Endpoint<GameDetailsModel>
}


