//
//  UserRepositoryTests.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import XCTest

@testable import Lloyds

class UserRepositoryTests: XCTestCase {
    
    var userRepository: UserRepository!
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!

    func testRepository_successResult() {
        let userExpectation = expectation(description: "user fetch success")
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 200, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        userRepository = UserRepositoryImpl(service: networkClient)
        
        var userResponse: [User]?
        
        userRepository.makeServiceCallToGetUsers { data, errorMessage in
            userResponse = data
            userExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userResponse)
        }
    }
    
    func testRepository_failureResult() {
        let errorExpectation = expectation(description: "user fetch failed")
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 404, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        userRepository = UserRepositoryImpl(service: networkClient)
        
        var errorResponse: String?
        
        userRepository.makeServiceCallToGetUsers { data, errorMessage in
            errorResponse = errorMessage?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    
}
