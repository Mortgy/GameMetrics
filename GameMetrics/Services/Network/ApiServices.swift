//
//  ApiServices.swift
//  GameMetrics
//
//  Created by Mortgy on 3/23/21.
//

import Foundation
import SENetworking

class ApiServices {
    func getGames(gamesRequest: GamesRequest, from cache: Bool, success: @escaping (GameResponseModel) -> Void, fail: @escaping (String) -> Void) -> (NetworkCancellable?, GameResponseModel?) {
        
        let endpoint = APIEndpoints.getGames(with: gamesRequest)
        let cacheName = (endpoint.path + "\(gamesRequest.page)").MD5()
        
        return (DIContainer.shared.apiDataTransferService.request(with: endpoint) { result in
            
            guard case let .success(response) = result else {
                
                fail("Failed to fetch data")
                return
            }
            
            cache ? DiskCacheManager.shared.add(response, for: cacheName, to: .backend) :
            success(response)
            
        }, cache ? gamesOfflineFirst(cacheName: cacheName) : nil)
    }
    
    func getGameDetails(gameDetailRequest: GameDetailsRequest,
                          success: @escaping (GameDetailsModel) -> Void,
                          fail: @escaping (String) -> Void) -> NetworkCancellable? {
        
        if DiskCacheManager.shared.valueExists("detailCacheId\(gameDetailRequest.id!)", in: .favoriteGameDetails) {
            if let gameDetails: GameDetailsModel = DiskCacheManager.shared.value("detailCacheId\(gameDetailRequest.id!)", from: .favoriteGameDetails) {
                success(gameDetails)
            }
            return nil
        } else {
            let endpoint = APIEndpoints.getGame(with: gameDetailRequest)
            return DIContainer.shared.apiDataTransferService.request(with: endpoint) { result in
                
                guard case let .success(response) = result else {
                    
                    fail("Failed to fetch data")
                    return
                }
                
                success(response)
            }
        }
    }
    
    func gamesOfflineFirst(cacheName: String) -> GameResponseModel? {
        if  DiskCacheManager.shared.valueExists(cacheName, in: .backend) {
            guard let response: GameResponseModel = DiskCacheManager.shared.value(cacheName, from: .backend) else {
                return nil
            }
            
            return response
        }
        
        return nil
    }
}
