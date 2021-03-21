//
//  GamesEndpoint.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import Foundation
import SENetworking

struct GamesRequest: Encodable {
    var page: Int = 0
    mutating func addPage() {
        page += 1
    }
}

protocol GamesRequestProtocol {
    var gamesRequest: GamesRequest { set get }
}

extension APIEndpoints {
    static func getGames(with GameRequestDTO: GamesRequest) -> Endpoint<GameResponseModel> {
        return Endpoint(path: "games",
                        method: .get,
                        queryParametersEncodable: GameRequestDTO)
    }
    
}
