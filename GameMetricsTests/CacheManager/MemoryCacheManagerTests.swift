//
//  MemoryCacheManagerTests.swift
//  GameMetricsTests
//
//  Created by Mortgy on 3/22/21.
//

import XCTest
@testable import GameMetrics

class MemoryCacheManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        MemoryCacheManager.shared.pop(value: "test", forList: .seen)

    }
    
    func testPop() throws {
        
        MemoryCacheManager.shared.pop(value: "test", forList: .seen)
        let testCache: [String] = MemoryCacheManager().values(in: .seen)
        XCTAssertEqual(testCache.count, 0, "Array count should be 0")
        
    }
    
    func testAppend() throws {
        
        MemoryCacheManager.shared.append(value: "test", forList: .seen)
        let testCache: [String] = MemoryCacheManager().values(in: .seen)
        
        XCTAssertEqual(testCache, ["test"])
        XCTAssertEqual(testCache.count, 1, "Array has 1 element")
        
    }
    
    func testValues() throws {
        
        MemoryCacheManager.shared.append(value: "test", forList: .seen)
        MemoryCacheManager.shared.append(value: "test", forList: .seen)
        
        let testCache: [String] = MemoryCacheManager.shared.values(in: .seen)
        XCTAssertEqual(testCache.count, 2, "Array count is 2")
        XCTAssertGreaterThan(testCache.count, 1, "Array count greater than 1")
        XCTAssertLessThan(testCache.count, 3, "Array count less than 3")

    }
    
    func testValueExists() throws {

        MemoryCacheManager.shared.append(value: "test", forList: .seen)
        let valueExists = MemoryCacheManager().valueExists(value: "test", in: .seen)
        XCTAssertTrue(valueExists, "test value exists")

    }

    func testAddAndValue() throws {
        
        MemoryCacheManager.shared.add("test", for: "key", to: nil)
        
        if let valueForKey: String = MemoryCacheManager.shared.value("key", from: nil) {
            XCTAssertEqual(valueForKey, "test", "add value 'key' for key 'key', valueForKey should hold value 'test'")
        } else {
            XCTFail("value 'test' should be added to key")
        }
    }
    
    func testRemove() {
        MemoryCacheManager.shared.add("test", for: "key", to: nil)
        MemoryCacheManager.shared.remove("key", from: nil)
        if let value: String = MemoryCacheManager.shared.value("key", from: nil) {
            XCTFail("\(value) not removed")
        } else {
            XCTAssertTrue(true, "'test' value removed from key 'key'")
        }
    }
}
