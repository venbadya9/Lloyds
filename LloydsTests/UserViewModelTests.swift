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
    let controller = UserListVC()
    
    let url = URL(string: "https://reqres.in/api/users")!
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    override func setUp() {
        controller.configureViewModel()
    }
    
    func testNetworkClient_successResult() {

        let userExpectation = expectation(description: "user")
        let reloadExpectation = XCTestExpectation(description: "reload closure triggered")
        var userResponse: [User]?
                
        mockSession = createMockSession(fromJsonFile: "User", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        let userViewModel = UserListViewModel(networkClient: sut)
        userViewModel.fetchUserList()
        
        userViewModel.reloadTableViewClosure = { () in
            reloadExpectation.fulfill()
        }
                    
        sut.getUsers(url: url) { user, error in
            userResponse = user
            
            XCTAssertEqual( userViewModel.numberOfCells, userResponse?.count )
            userExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userResponse)
        }
    }
    
    func testNetworkClient_404Result() {
        
        let errorExpectation = expectation(description: "error")
        let alertExpectation = XCTestExpectation(description: "Alert message is shown")
        var errorResponse: String?
        
        mockSession = createMockSession(fromJsonFile: "User", andStatusCode: 404, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        let userViewModel = UserListViewModel(networkClient: sut)
        userViewModel.fetchUserList()
        
        userViewModel.showAlertClosure = { [weak userViewModel] in
            self.controller.showAlert(userViewModel?.alertMessage ?? "")
            XCTAssertEqual(userViewModel?.alertMessage, "Bad Url")
            alertExpectation.fulfill()
        }
        
        sut.getUsers(url: url) { user, error in
            errorResponse = error?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    func testNetworkClient_NoData() {
        
        let errorExpectation = expectation(description: "nodata")
        var errorResponse: String?
        
        mockSession = createMockSession(fromJsonFile: "User", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        sut.getUsers(url: url) { user, error in
            errorResponse = error?.rawValue
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    private func loadJsonData(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }
    
    private func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {

        let data = loadJsonData(file: file)
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
