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
        self.useCase.fetchUsers { result in
            switch result {
            case let .success(userList):
                let user = (userList as UserList).data
                self.users = user
                self.output?.handleSuccess()
            case let .failure(error):
                self.output?.handleFailure(error.rawValue)
            }
        }
    }
}
