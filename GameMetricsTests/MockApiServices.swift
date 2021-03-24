//
//  MockApiServices.swift
//  GameMetricsTests
//
//  Created by Mortgy on 3/24/21.
//

import XCTest
@testable import SENetworking
@testable import GameMetrics

class MockApiServices: ApiServices {
    
    var isGetGamesCalled = false
    var gamesSuccessCompletitionClosure: ((GameResponseModel) -> Void)?
    var gamesFilCompletitionClosure: ((String) -> Void)?
    
    
    func getGames(gamesRequest: GamesRequest, from cache: Bool, success: @escaping (GameResponseModel) -> Void, fail: @escaping (String) -> Void) -> (NetworkCancellable?, GameResponseModel?) {
        
        isGetGamesCalled = true
        
        return (nil, nil)
    }
    
    func getGameDetails(gameDetailRequest: GameDetailsRequest, success: @escaping (GameDetailsModel) -> Void, fail: @escaping (String) -> Void) -> NetworkCancellable? {
        isGetGamesCalled = true
        
        return nil
    }
    
    func gamesOfflineFirst(cacheName: String) -> GameResponseModel? {
        nil
    }
    
    func testGetGames() {
        
    }
    
    func testGetGamesFailed() {
        
    }


}
