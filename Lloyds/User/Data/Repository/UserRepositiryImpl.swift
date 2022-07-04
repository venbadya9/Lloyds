//
//  UserRepositiryImpl.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class UserRepositoryImpl: UserRepository {
    
    // MARK: Private Variables
    
    private let service: NetworkClient
    
    // MARK: Object Lifecycle
    
    init(service: NetworkClient) {
        self.service = service
    }
    
    // MARK: Protocol Functions
    
    func makeServiceCallToGetUsers(completion: @escaping CompletionHandler) {
        return service.getUsers(url: Endpoints.userListUrl, completion: completion)
    }
    
}
