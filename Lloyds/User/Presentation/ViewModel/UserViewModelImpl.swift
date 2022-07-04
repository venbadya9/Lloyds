//
//  UserViewModelImpl.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class UserViewModelImpl: UserViewModel {
    
    // MARK: Variables
    
    var output: CallbackStatus?
    var users: [User] = []
    
    // MARK: Private Variables
    
    private let useCase: UserUseCase
    
    // MARK: Object Lifecycle
    
    init(useCase: UserUseCase) {
        self.useCase = useCase
    }
    
    // MARK: Protocol Functions
    
    func fetchUsers() {
        useCase.fetchUsers { data, errorMessage in
            if let error = errorMessage {
                self.output?.failure(error.rawValue)
            } else {
                if let users = data {
                    self.users = users
                    self.output?.success()
                }
            }
        }
    }
}
