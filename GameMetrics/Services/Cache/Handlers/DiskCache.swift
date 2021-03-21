//
//  DiskCache.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

class DiskCacheManager : Cache {
    
    var cacheDirectory : URL {
        let homeDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return homeDirectory.appendingPathComponent("cache")
    }
    
    init() {
        createDirectory(at: cacheDirectory.absoluteString)
    }
    
}

extension DiskCacheManager {
    func add<T>(_ value: T, for key: String, to list: CacheLists?) where T: Codable {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            try data.write(to: URL(string: path)!)
        } catch {
            print(error)
        }
        
    }
    
    func value<T: Codable>(_ key: String, from list: CacheLists?) -> T? {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        
        guard let data = try? Data(contentsOf: URL(string: path)!), let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? T else {
            return nil
        }
        
        return value
    }
    
    func values<T>(in list: CacheLists) -> [T] {
        do {
            let path = getCachePath(for: nil, in: list.rawValue)
            
            var isDirectory: ObjCBool = true
            if FileManager.default.fileExists(atPath: URL(string: path)!.path, isDirectory: &isDirectory) {
                let contentList = try FileManager.default.contentsOfDirectory(at: URL(string: path)!, includingPropertiesForKeys: nil)
                
                var results = [T]()
                
                for url in contentList {
                    print(url.absoluteString)
                    if let data = try? Data(contentsOf: url), let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? T {
                        results.append(value)
                    }
                }
                
                return results
                
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    func remove(_ key: String, from list: CacheLists?) {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        
        if FileManager.default.isDeletableFile(atPath: path) {
            try? FileManager.default.removeItem(at: URL(string: path)!)
        }
    }
    
    func valueExists(_ key: String, in list: CacheLists?) -> Bool {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        
        return false
    }
}

extension DiskCacheManager {
    func getCachePath(for key: String?, in list: String?) -> String {
        var path: URL = cacheDirectory
        
        if let list = list {
            path = path.appendingPathComponent(list)
            createDirectory(at: path.absoluteString)
        }
        
        if let key = key {
            path = path.appendingPathComponent(key)
        }
        
        return path.absoluteString
    }
    
    func createDirectory(at path: String) {
        if !FileManager.default.fileExists(atPath: URL(string: path)!.path) {
            try? FileManager.default.createDirectory(at: URL(string: path)!, withIntermediateDirectories: false, attributes: nil)
        }
    }
}
