//
//  UserUseCaseTest.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 13/07/22.
//

import XCTest
@testable import Lloyds

class UserUseCaseTest: XCTestCase {

    var useCase: UserUseCase!
    let repository = MockRepository()
    
    override func setUpWithError() throws {
        useCase = UserUseCase(respository: repository)
    }
    
    func testSuccessScenario() {
        let expecatation = expectation(description: "Success")
        repository.userList = UserDomainListMockData.userDomainList
        
        useCase.fetchUserList { result in
            switch result {
            case let .success(userList):
                let users = userList.data
                if users.count > 0 {
                    expecatation.fulfill()
                }
            case let .failure(error):
                XCTFail("Failure not expected \(error.localizedDescription)")
            }
        }
        wait(for: [expecatation], timeout: 1.0)
    }
    
    func testFailureScenario() {
        let expecatation = expectation(description: "Failure")
        repository.error = NSError(domain: "Failed", code: 0)
        
        useCase.fetchUserList { result in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case .failure(_):
                expecatation.fulfill()
            }
        }
        wait(for: [expecatation], timeout: 1.0)
    }
}
