//
//  NetworkClient.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 01/07/22.
//

import Foundation

enum APIError: String, Error {
    case noData = "No Data"
    case badUrl = "Bad Url"
    case permissionDenied = "You donot have permission"
}

typealias CompletionHandler = (_ data: [User]?, _ errorMessage: APIError?) -> Void

protocol NetworkClientProtocol {
    func getUsers(url: URL, completion: @escaping CompletionHandler)
}

class NetworkClient: NetworkClientProtocol {
    
    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getUsers(url: URL, completion: @escaping (_ data: [User]?, _ errorMessage: APIError?) -> Void) {

        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  let data = data else {
                completion(nil, .noData)
                return
            }

            switch statusCode {
            case 200:
                let json = try! JSONDecoder().decode(UserList.self, from: data)
                let users  = json.data
                completion(users, nil)
            case 404:
                completion(nil, .badUrl)
            default:
                completion(nil, .permissionDenied)
            }
        }
        dataTask.resume()
    }
}
