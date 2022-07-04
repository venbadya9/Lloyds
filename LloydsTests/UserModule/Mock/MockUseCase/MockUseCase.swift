//
//  MockUseCase.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class MockUseCase: UserUseCase {
    
    var userResponse: [User]?
    var error: Error?
    
    func fetchUsers(completion: @escaping CompletionHandler) {
        if let error = error {
            completion(nil, .badUrl)
        } else {
            if let users = userResponse {
                completion(users, nil)
            }
        }
    }
}
