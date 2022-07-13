//
//  LloydsUITests.swift
//  LloydsUITests
//
//  Created by Venkatesh Badya on 12/07/22.
//

import XCTest

class LloydsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testTableView() {
        app.launch()
        
        let userTableView = app.tables["table--userTableView"]
        XCTAssertTrue(userTableView.exists, "The user tableview exists")
        
        let tableCells = userTableView.cells
        XCTAssert(tableCells.element.waitForExistence(timeout: 5.0))
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
         
            let expectation = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                
                if i == (count - 1) {
                    expectation.fulfill()
                }
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
         
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
    func assertContains() -> XCUIElement {
        let string = ".in"
        let predicate = NSPredicate(format: "label CONTAINS[c] '\(string)'")
        return app.staticTexts.matching(predicate).firstMatch
    }
}
