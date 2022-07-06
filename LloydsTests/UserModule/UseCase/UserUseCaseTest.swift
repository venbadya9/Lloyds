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
    var repository = MockRepository()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repository.service = NetworkClient()
        useCase = UserUseCaseImpl(repository: repository)
    }
    
    func testUseCase_successResult() {
        let userExpectation = expectation(description: "user fetch success")
        
        useCase.fetchUsers { result in
            switch result {
            case.success(_):
                if let userCount = self.repository.users?.count,
                   userCount > 1 {
                    userExpectation.fulfill()
                }
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(self.repository.users)
        }
    }
    
    func testUseCase_failureResult() {
        let errorExpectation = expectation(description: "user fetch failed")
        self.repository.baseUrl = URL(string: "https://reqres.in/users")!
        
        useCase.fetchUsers {  result in
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
