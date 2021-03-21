//
//  MemoryCache.swift
//  GameMetrics
//
//  Created by Mortgy on 3/18/21.
//

import Foundation

class MemoryCacheManager: Cache {
    
    func append<T>(value: T, forList list: CacheLists) where T: Codable{
        
        var array = [T]()
        
        if let encodedData = UserDefaults.standard.value(forKey: list.rawValue) as? Data,
           let decodedData = try? JSONDecoder().decode([T].self, from: encodedData) {
            array = decodedData
            array.append(value)
        } else {
            array.append(value)
        }
        
        if let data = try? JSONEncoder().encode(array) {
            UserDefaults.standard.setValue(data, forKey: list.rawValue)
        }
        
    }
    
    func pop<T>(value: T, forList list: CacheLists) where T: Comparable, T: Codable {
        
        guard let encodedData = UserDefaults.standard.value(forKey: list.rawValue) as? Data,
              let decodedData = try? JSONDecoder().decode([T].self, from: encodedData) else {
            return
        }
        
        var array = decodedData
        array.append(value)
        array.removeAll(where: {$0 == value})
        
        if let data = try? JSONEncoder().encode(array) {
            UserDefaults.standard.setValue(data, forKey: list.rawValue)
        }
    }
    
    func valueExists<T>(value: T, in list: CacheLists) -> Bool where T: Codable, T: Comparable {
        guard let encodedData = UserDefaults.standard.value(forKey: list.rawValue) as? Data,
              let decodedData = try? JSONDecoder().decode([T].self, from: encodedData) else {
            return false
        }

        return decodedData.filter({ return $0 == value }).count > 0 ? true : false
    }
    
    func add<T: Codable>(_ value: T, for key: String, to list: CacheLists?) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
    
    func value<T>(_ key: String, from list: CacheLists?) -> T? where T: Codable {
        
        guard let data = UserDefaults.standard.value(forKey: key) as? Data, let value = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return value
    }
    
    func remove(_ key: String, from list: CacheLists?) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func valueExists(_ key: String, in list: CacheLists?) -> Bool {
        if UserDefaults.standard.value(forKey: key) != nil {
            return true
        }
        return false
    }
}

