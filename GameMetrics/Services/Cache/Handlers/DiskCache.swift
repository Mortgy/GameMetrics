//
//  DiskCache.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import UIKit

class DiskCache : CacheManager {
    
    static var `default`: DiskCache { get { DiskCache() } }
    
    let fileManager = FileManager()
    var cacheDirectory : String {
        let homeDirectory = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first!
        return "\(homeDirectory)/cache"
    }
    
    override init() {
        super.init()
        if !fileManager.fileExists(atPath: cacheDirectory) {
            try? fileManager.createDirectory(at: URL(string: cacheDirectory)!, withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    func add<T: Codable>(value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            try? data.write(to: URL(string: "\(cacheDirectory)/\(key)")!, options: .atomic)
        }
    }
    
    func value<T: Codable>(forKey key: String) -> T? {
        guard let path = URL(string: "\(cacheDirectory)/\(key)") else {
            return nil
        }
        
        if let data = try? Data(contentsOf: path) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
    
    func remove(key: String) {
        guard let path = URL(string: "\(cacheDirectory)/\(key)") else {
            return
        }
        
        if fileManager.isDeletableFile(atPath: path.absoluteString) {
            try? fileManager.removeItem(at: path)
        }
    }
}
