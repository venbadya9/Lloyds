//
//  UserUseCaseImpl.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class UserUseCaseImpl: UserUseCase {
    
    // MARK: Private Variables
    
    private let repository: UserRepository
    
    // MARK: Object Lifecycle
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    // MARK: Protocol Functions
    
    func fetchUsers(completion: @escaping (Result<UserList, APIError>) -> Void) {
        return repository.makeServiceCallToGetUsers(url: nil, completion: completion)
    }
}
