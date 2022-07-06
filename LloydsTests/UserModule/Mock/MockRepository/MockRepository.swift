//
//  MockRepository.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 06/07/22.
//

import Foundation

class MockRepository: UserRepository {

    var error: Error?
    var users: [User]?
    var service: NetworkClient?
    var baseUrl = URL(string: "https://reqres.in/api/users")!
    
    func makeServiceCallToGetUsers(url: URL?, completion: @escaping (Result<UserList, APIError>) -> Void) {
        service?.getApiData(requestUrl: url ?? baseUrl, resultType: UserList.self, completion: { result in
            switch result {
            case.success(let userList):
                self.users = userList.data
                completion(.success(userList))
                
            case .failure(let err):
                self.error = err
                completion(.failure(.dataError))
            }
        })
    }
}
