//
//  GamifyAssigmentTests.swift
//  GamifyAssigmentTests
//
//  Created by Atul Sharan on 27/02/24.
//

import XCTest
@testable import GamifyAssigment

final class GamifyAssigmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testGameGenreAPI() throws {
        let api = GameGenreAPI()
        let param = ["key":Constants.APIKeys.kClientKey];
        let request = api.makeRequest(from: param)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "api.rawg.io")
    }
    
    func testGameListAPI() throws {
        let api = GameListAPI()
        let param = ["key":Constants.APIKeys.kClientKey, "genres": 4] as [String : Any];
        let request = api.makeRequest(from: param)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "api.rawg.io")
    }
    
    func testGameDetailAPI() throws {
        let api = GameDetailAPI()
        let param = ["key":Constants.APIKeys.kClientKey, "id": "3249"];
        let request = api.makeRequest(from: param)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "api.rawg.io")
    }
}
