//
//  CacheManager.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import Foundation

enum CacheLists: String {
    case seen
    case favoriteGames
    case favoriteGameDetails
}

protocol Cache {
    func add<T: Codable>(_ value: T, for key: String, to list: CacheLists?)
    func remove(_ key: String, from list: CacheLists?)
    func value<T: Codable>(_ key: String, from list: CacheLists?) -> T?
    func valueExists(_ key: String, in list: CacheLists?) -> Bool
}
