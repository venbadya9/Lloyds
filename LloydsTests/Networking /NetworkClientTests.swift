//
//  NetworkClientTests.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 13/07/22.
//

import XCTest
@testable import Lloyds

class NetworkClientTests: XCTestCase {

    var service: NetworkManager!
    let testUrl = URL(string: "TestURL")!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession.init(configuration: configuration)
        service = NetworkManager(session: urlSession)
    }
    
    func testSuccessfulResponse() {
        
        let expecatation = expectation(description: "Success")
        let data = loadJsonData(file: "User")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.testUrl else {
                throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
            }
            
            let response = HTTPURLResponse(url: self.testUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        service.request(fromUrl: testUrl) {  (result: Result<UserDataListDTO, Error>) in
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
    
    
    func testParsingFailure() {
        let data = Data()
        let errorExpectation = expectation(description: "Failure")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.testUrl, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        service.request(fromUrl: testUrl) { (result: Result<UserDataListDTO, Error>) in
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
