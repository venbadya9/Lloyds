//
//  APIServiceTest.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 01/07/22.
//

import XCTest
@testable import Lloyds

class NetworkClientTests: XCTestCase {

    var service: NetworkClient!
    
    let url = URL(string: "https://reqres.in/api/users")!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        service = NetworkClient(withSession: urlSession)
    }
    
    func testSuccessfulResponse() {
        
        let data = loadJsonData(file: "User")
        let userExpectation = expectation(description: "user fetch success")
        var userResponse: [User]?
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.url else {
                throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
            }
            
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // Call API.
        service.getApiData(requestUrl: url, resultType: UserList.self) { result in
            switch result {
            case let .success(userList):
                let users = (userList as UserList).data
                userResponse = users
                if let userCount = userResponse?.count, userCount > 1 {
                    userExpectation.fulfill()
                }
            case let .failure(error):
                XCTFail("Error was not expected: \(error)")
            }
        }
        
        wait(for: [userExpectation], timeout: 1.0)
    }
    
    
    func testParsingFailure() {
        let data = Data()
        let errorExpectation = expectation(description: "user fetch failed")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // Call API.
        service.getApiData(requestUrl: url, resultType: UserList.self) { result in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(_):
                errorExpectation.fulfill()
            }
        }
        wait(for: [errorExpectation], timeout: 1.0)
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
}
