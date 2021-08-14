//
//  HomeViewModelTests.swift
//  FastAssignmentTests
//
//  Created by Jianhua Wang on 8/12/21.
//

import XCTest
@testable import FastAssignment

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeViewModel() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let homeViewModel = HomeViewModel()
        let expectation = self.expectation(description: "HomeViewModel test")
        homeViewModel.searchOMDB(term: "Girl") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertNotEqual(homeViewModel.searchResult?.search?.count ?? 0, 0, "No search results")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
