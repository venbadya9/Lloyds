//
//  UserViewModelImpl.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class UserViewModel: IUserViewModel {
    
    // MARK: Variables
    
    var output: CallbackStatus?
    var users: [UserCellViewModel] = [UserCellViewModel]()
    
    // MARK: Private Variables
    
    private let useCase: IUserUseCase
    
    // MARK: Object Lifecycle
    
    init(useCase: IUserUseCase) {
        self.useCase = useCase
    }
    
    // MARK: Protocol Functions
    
    func fetchUsers() {
        
        self.useCase.fetchUserList { result in
            switch result {
            case let .success(userList):
                    let users = userList.data
                    self.processFetchedUsers(users)
                    self.output?.handleSuccess()
            case let .failure(error):
                self.output?.handleFailure(error.localizedDescription)
            }
        }
    }
    
    // MARK: Methods
    
    func processFetchedUsers(_ users: [UserList.User]) {
        var userCellViewModel = [UserCellViewModel]()
        for user in users {
            userCellViewModel.append(generateCellViewModel(user))
        }
        self.users = userCellViewModel
    }
    
    func generateCellViewModel(_ user: UserList.User) -> UserCellViewModel {
        
        return UserCellViewModel(
            email: user.email,
            firstName:user.firstName,
            lastName: user.lastName,
            avatar: user.avatar
        )
    }
}
