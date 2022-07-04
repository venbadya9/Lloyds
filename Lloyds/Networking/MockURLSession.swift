//
//  MockURLSession.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 01/07/22.
//

import Foundation

// MARK: - DataTask

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {
    
    }
}

// MARK: - URLSession

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class MockURLSession: URLSessionProtocol {
    
    var dataTask = MockURLSessionDataTask()
    var completionHandler: (data: Data?, response: URLResponse?, err: Error?)
    
    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.data, self.completionHandler.response, self.completionHandler.err)
        return dataTask
    }
}
