//
//  MockUseCase.swift
//  LloydsTests
//
//  Created by Venkatesh Badya on 06/07/22.
//

import Foundation

class MockUseCase: UserUseCase {
    
    var error: Error?
    var users: [User]?
    var repository: MockRepository?
    
    func fetchUsers(completion: @escaping (Result<UserList, APIError>) -> Void) {
        repository?.makeServiceCallToGetUsers(url: nil, completion: { result in
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
