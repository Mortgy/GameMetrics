//
//  GameCellViewModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/21/21.
//

import Foundation

struct GameCellViewModel {
    private var game: GameModel
    
    init(game: GameModel) {
        self.game = game
    }
    
    var name: String? {
        game.name
    }
    
    var genres: String? {
        guard let genres: [Genre] = game.genres else {
            return ""
        }
        return genres.map({ $0.name }).joined(separator: ", ")
    }
    
    var imageURL: URL? {
        return URL(string: game.backgroundImage ?? "")
    }
    
    var seen: Bool {
        return MemoryCacheManager.shared.valueExists(value: game.id, in: .seen)
    }
    
    var metacritic: String? {
        guard let metacritic = game.metacritic else {
            return nil
        }
        
        return "\(metacritic)"
    }
    
    func markAsSeen() {
        MemoryCacheManager.shared.append(value: game.id, forList: .seen)
        NotificationCenter.default.post(name: .seenItemUpdated, object: nil)
    }
    
    
}
