//
//  DiskCache.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

class DiskCacheManager : Cache {
    
    static let shared = DiskCacheManager()
    
    var cacheDirectory : URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("cache"))!
    
    init() {
        createDirectory(at: cacheDirectory.absoluteString)
    }
    
}

extension DiskCacheManager {
    func add<T>(_ value: T, for key: String, to list: CacheLists?) where T: Codable {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        DispatchQueue.global(qos: .background).async {
            do {
                
                let data = try? JSONEncoder().encode(value)
                try data?.write(to: path)
                
                
            } catch {
                print(error)
            }
        }
    }
    
    func value<T: Codable>(_ key: String, from list: CacheLists?) -> T? {
        
        let path = getCachePath(for: key, in: list?.rawValue)
        
        guard let data = try? Data(contentsOf: path), let value = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return value
    }
    
    func values<T>(in list: CacheLists) -> [T] where T: Codable {
        do {
            let path = getCachePath(for: nil, in: list.rawValue)
            
            var isDirectory: ObjCBool = true
            if FileManager.default.fileExists(atPath: path.path, isDirectory: &isDirectory) {
                let contentList = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
                
                var results = [T]()
                
                for url in contentList {
                    if let data = try? Data(contentsOf: url), let value = try? JSONDecoder().decode(T.self, from: data) {
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
        
        if FileManager.default.isDeletableFile(atPath: path.path) {
            try? FileManager.default.removeItem(at: path)
        }
    }
    
    func valueExists(_ key: String, in list: CacheLists?) -> Bool {
        
        let path = getCachePath(for: key, in: list?.rawValue).path
        
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        
        return false
    }
}

extension DiskCacheManager {
    func getCachePath(for key: String?, in list: String?) -> URL {
        var path: URL = cacheDirectory
        
        if let list = list {
            path = path.appendingPathComponent(list)
            createDirectory(at: path.absoluteString)
        }
        
        if let key = key {
            path = path.appendingPathComponent(key)
        }
        
        return path
    }
    
    func createDirectory(at path: String) {
        if let url = URL(string: path) {
            if !FileManager.default.fileExists(atPath: url.path) {
                try? FileManager.default.createDirectory(at: URL(string: path)!, withIntermediateDirectories: false, attributes: nil)
            }
        }
        
    }
}
