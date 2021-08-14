//
//  OMDBServiceTests.swift
//  FastAssignmentTests
//
//  Created by Jianhua Wang on 8/12/21.
//

import XCTest
@testable import FastAssignment

class OMDBServiceTests: XCTestCase {
    let service = OMDBService()
    
    override func setUpWithError() throws {
    }

    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOMDBService() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var dataResult: Result<OMDBSearchResult, Error>?
        let expectation = self.expectation(description: "Request OMDB search.")
        service.fetchOMDB(searchTerm: "Girl") { (result) in
            dataResult = result
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 10 seconds.
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            switch dataResult {
            case .success(let searchResult):
                XCTAssertNotEqual(searchResult.search?.count ?? 0, 0)
            case .failure,
                 .none:
                XCTFail()
            }
        }
    }

}
