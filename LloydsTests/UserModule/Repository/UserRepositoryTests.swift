//
//  UserRepositoryTests.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import XCTest

@testable import Lloyds

class UserRepositoryTests: XCTestCase {
    
    var userRepository: UserRepositoryImpl!
    var networkClient = NetworkClient()
    
    let url = URL(string: "https://reqres.in/api/users")!
    
    override func setUpWithError() throws {
        userRepository = UserRepositoryImpl(service: networkClient)
    }

    func testRepository_successResult() {
        let userExpectation = expectation(description: "user fetch success")
        var userResponse: [User]?
                
        userRepository.makeServiceCallToGetUsers(url: nil) { result in
            switch result {
            case.success(let userList):
                userResponse = userList.data
                if let userCount = userResponse?.count,
                   userCount > 1 {
                    userExpectation.fulfill()
                }
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userResponse)
        }
    }
    
    func testRepository_failureResult() {
        let errorUrl = URL(string: "https://reqres.in/users")!
        let errorExpectation = expectation(description: "user fetch failed")
        
        userRepository.makeServiceCallToGetUsers(url: errorUrl) { result in
            switch result {
            case.success(_):
                XCTFail("Success was not expected")
            case .failure(_):
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorExpectation)
        }
    }
}
