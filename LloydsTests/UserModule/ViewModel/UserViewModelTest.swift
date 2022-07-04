//
//  UserViewModelTest.swift
//  LyodsAssesmentTests
//
//  Created by Mayank Juyal on 29/06/22.
//

import XCTest

@testable import Lloyds

class UserViewModelTest: XCTestCase {
    
    var userViewModel: UserViewModel?
    var useCase: UserUseCase!
    var repository: UserRepository!
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!
    
    private var userExpectation: XCTestExpectation!
    
    func testViewModel_successResult() {
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 200, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        repository = UserRepositoryImpl(service: networkClient)
        useCase = UserUseCaseImpl(repository: repository)
        
        userExpectation = expectation(description: "user fetch success")
        
        userViewModel = UserViewModelImpl(useCase: useCase)
        userViewModel?.output = self
        userViewModel?.fetchUsers()
        
        waitForExpectations(timeout: 1) { _ in }
    }
    
    func testViewModel_failureResult() {
        
        mockSession = Helper.shared.createMockSession(fromJsonFile: "User", andStatusCode: 404, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        repository = UserRepositoryImpl(service: networkClient)
        useCase = UserUseCaseImpl(repository: repository)
        
        userExpectation = expectation(description: "user fetch success")
        
        userViewModel = UserViewModelImpl(useCase: useCase)
        userViewModel?.output = self
                
        userViewModel?.fetchUsers()
        
        waitForExpectations(timeout: 1) { _ in }
    }
}

extension UserViewModelTest: CallbackStatus {
    
    func handleSuccess() {
        userExpectation.fulfill()
    }
    
    func handleFailure(_ error: String) {
        XCTAssertTrue(error == "Bad Url")
        userExpectation.fulfill()
    }
    
}
