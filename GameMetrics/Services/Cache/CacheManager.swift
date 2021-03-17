//
//  CacheManager.swift
//  GameMetrics
//
//  Created by Mortgy on 3/17/21.
//

import Foundation

enum CacheType {
    case Disk
    case Memory
}

protocol Cache {
    func add<T: Codable>(value: T, forKey key: String)
    func remove(key: String)
    func value<T: Codable>(forKey key: String) -> T?
}

class CacheManager: NSObject {
    
    func add<T: Codable>(value: T, forKey key: String, cacheType: CacheType) {
        switch cacheType {
        case .Disk:
            DiskCache().add(value: value, forKey: key)
            break
        case .Memory:
            MemoryCache().add(value: value, forKey: key)
            break
        }
    }
    
    func remove(key: String, cacheType: CacheType) {
        switch cacheType {
        case .Disk:
            DiskCache().remove(key: key)
            break
        case .Memory:
            MemoryCache().remove(key: key)
            break
        }
    }
    
    func value<T: Codable>(forKey key: String, cacheType: CacheType) -> T? {
        switch cacheType {
        case .Disk:
            return DiskCache().value(forKey: key)
        case .Memory:
            return MemoryCache().value(forKey: key)
        }
    }
}

