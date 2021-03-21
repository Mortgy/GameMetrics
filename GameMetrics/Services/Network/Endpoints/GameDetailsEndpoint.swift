//
//  GameDetailsEndpoint.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import Foundation
import SENetworking

struct GameDetailsRequest: Encodable {
    let id: Int?
}

protocol GameDetailsRequesttProtocol {
    var gameDetailRequest: GameDetailsRequest { set get }
}

extension APIEndpoints {
    
    static func getGame(with GameDetailRequestDTO: GameDetailsRequest) -> Endpoint<GameDetailsModel> {
        return Endpoint(path: "games/\(GameDetailRequestDTO.id!)",
                        method: .get)
    }
}
