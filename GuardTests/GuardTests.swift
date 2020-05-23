//
//  GuardTests.swift
//  GuardTests
//
//  Created by Denys Litvinskyi on 23.05.2020.
//  Copyright © 2020 Litvinskii Denis. All rights reserved.
//

import XCTest

final class GuardTests: XCTestCase {
    
    func testSuccess() {
        XCTAssert(true)
    }
    
    func testFailed() {
        XCTFail("Failed...")
    }
}
