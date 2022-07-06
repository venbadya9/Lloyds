//
//  LloydsUITests.swift
//  LloydsUITests
//
//  Created by Venkatesh Badya on 30/06/22.
//

import XCTest

class LloydsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUser() throws {
        let app = XCUIApplication()
        app.launch()
        
        let isUserNameLoaded = app.tables.cells.staticTexts["George Bluth"].exists
        XCTAssertTrue(isUserNameLoaded)
    }
    
    func testUserCount() throws {
        let app = XCUIApplication()
        app.launch()
        
        let isCompleteListLoaded = app.tables.cells.count > 1
        XCTAssertTrue(isCompleteListLoaded)
    }
}
