//
//  HomeViewModelTests.swift
//  GameMetricsTests
//
//  Created by Mortgy on 3/22/21.
//

import XCTest
@testable import GameMetrics

class HomeViewModelTests: XCTestCase {
    
    let homeCoordinator = HomeCoordinator()
    var homeViewModel: HomeViewModel!
    var mockAPIServices = MockApiServices()

    override func setUp() {
        super.setUp()
        homeViewModel = HomeViewModel(coordinator: homeCoordinator, apiServices: mockAPIServices)
    }
    
    func test_fetchData () {
        //
        homeViewModel.fetchData()
        
        //Assert
        XCTAssert(mockAPIServices.isGetGamesCalled)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
