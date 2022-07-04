//
//  UserUseCaseTest.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import XCTest
@testable import Lloyds


class UserUseCaseTest: XCTestCase {
    
    var useCase: UserUseCase!
    var repository: UserRepository!
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!
    
    func testUseCase_successResult() {
        let userExpectation = expectation(description: "user fetch success")
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 200, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        repository = UserRepositoryImpl(service: networkClient)
        useCase = UserUseCaseImpl(repository: repository)
        
        var userResponse: [User]?
        
        useCase.fetchUsers { data, errorMessage in
            userResponse = data
            userExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userResponse)
        }
    }
    
    func testUseCase_failureResult() {
        let errorExpectation = expectation(description: "user fetch failed")
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 404, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        repository = UserRepositoryImpl(service: networkClient)
        useCase = UserUseCaseImpl(repository: repository)
        
        var errorResponse: String?
        
        useCase.fetchUsers { data, errorMessage in
            errorResponse = errorMessage?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
}
