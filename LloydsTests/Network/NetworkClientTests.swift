//
//  APIServiceTest.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 01/07/22.
//

import XCTest
@testable import Lloyds

class NetworkClientTests: XCTestCase {

    var sut: NetworkClient!
    var mockSession: MockURLSession!
    
    let url = URL(string: "https://reqres.in/api/users")!
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testNetworkClient_successResult() {

        let userExpectation = expectation(description: "user fetch success")
        var userResponse: [User]?
                
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)
                    
        sut.getUsers(url: url) { user, error in
            userResponse = user
            userExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userResponse)
        }
    }
    
    func testNetworkClient_404Result() {
        
        let errorExpectation = expectation(description: "user fetch failed")
        var errorResponse: String?
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 404, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        sut.getUsers(url: url) { user, error in
            errorResponse = error?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    func testNetworkClient_NoData() {
        
        let errorExpectation = expectation(description: "user fetch failed")
        var errorResponse: String?
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        sut.getUsers(url: url) { user, error in
            errorResponse = error?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
}
