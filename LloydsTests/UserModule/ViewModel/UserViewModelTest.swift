//
//  UserViewModelTest.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//
import XCTest

@testable import Lloyds

class UserViewModelTest: XCTestCase {
    
    var userViewModel: UserViewModel?
    var useCase = MockUseCase()
    let repository = MockRepository()
    
    private var userExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        repository.service = NetworkClient()
        useCase.repository = repository
        
        userViewModel = UserViewModelImpl(useCase: useCase)
        userViewModel?.output = self
    }
    
    func testViewModel_successResult() {

        userExpectation = expectation(description: "user fetch success")
        userViewModel?.fetchUsers()
        
        waitForExpectations(timeout: 1) { _ in }
    }
    
    func testViewModel_failureResult() {
        
        repository.baseUrl = URL(string: "https://reqres.in/users")!
        userExpectation = expectation(description: "user fetch success")
        userViewModel?.fetchUsers()
        
        waitForExpectations(timeout: 1) { _ in }
    }
}

extension UserViewModelTest: CallbackStatus {
    
    func handleSuccess() {
        userExpectation.fulfill()
    }
    
    func handleFailure(_ error: String) {
        XCTAssertTrue(error == "Data not in correct format")
        userExpectation.fulfill()
    }
    
}
