//
//  MockRepository.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class MockRepository: UserRepository {
    
    var userResponse: [User]?
    var error: Error?
    
    func makeServiceCallToGetUsers(completion: @escaping CompletionHandler) {
        if let _ = error {
            completion(nil, .badUrl)
        } else {
            if let users = userResponse {
                completion(users, nil)
            }
        }
    }
}
