//
//  MemoryCache.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit

class MemoryCache: CacheManager {
    
    static var `default`: MemoryCache { get { MemoryCache() } }
    
    func add<T: Codable>(value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
    
    func value<T: Codable>(forKey key: String) -> T? {
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

