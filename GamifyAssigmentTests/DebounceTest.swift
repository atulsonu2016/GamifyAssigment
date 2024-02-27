//
//  DebounceTest.swift
//  GamifyAssigmentTests
//
//  Created by Atul Sharan on 27/02/24.
//

import Foundation
import XCTest
@testable import GamifyAssigment


class DebouncerTests: XCTestCase {
    
    var debouncer: Debouncer!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        debouncer = Debouncer(delay: 0.5)
        expectation = expectation(description: "Action executed")
    }
    
    override func tearDown() {
        debouncer = nil
        expectation = nil
        super.tearDown()
    }
    
    func testDebouncer() {
        debouncer.debounce {
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMultipleDebounceCalls() {
        for _ in 1...5 {
            debouncer.debounce {
                self.expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
