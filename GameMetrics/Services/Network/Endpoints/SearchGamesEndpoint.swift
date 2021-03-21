//
//  SearchGamesEndpoint.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import Foundation
import SENetworking

struct GameSearchRequest: Encodable {
    let search: String?
    var page: Int = 0
    
    mutating func addPage() {
        page += 1
    }
}

protocol GameSearchRequestProtocol {
    var gameSearchRequest: GameSearchRequest { set get }
}

extension APIEndpoints {
    
    static func getSearchGames(with GameSearchRequestDTO: GameSearchRequest) -> Endpoint<GameResponseModel> {
        return Endpoint(path: "games",
                        method: .get,
                        queryParametersEncodable: GameSearchRequestDTO)
    }

}
