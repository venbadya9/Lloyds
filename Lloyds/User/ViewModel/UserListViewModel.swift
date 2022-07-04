//
//  UserListViewModel.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 30/06/22.
//

import Foundation

class UserListViewModel {
    
    // MARK: Constants
    
    let networkClient: NetworkClientProtocol
    let baseUrl = URL(string: "https://reqres.in/api/users")!
    
    // MARK: Private Variables
    
    private var user: [User] = [User]()
    
    // Updating cellModel once fetched
    private var cellViewModels: [UserCellViewModel] = [UserCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    // MARK: Variables
    
    // For showing alert in case of error
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    // Fetching number of cells
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // Binding Variables
    var showAlertClosure: (()->())?
    var reloadTableViewClosure: (()->())?

    // MARK: Object Lifecycle
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: Methods
    
    // Fetching user's list from server
    func fetchUserList() {
        
        networkClient.getUsers(url: self.baseUrl) { data, errorMessage in
            if let error = errorMessage {
                self.alertMessage = error.rawValue
            } else {
                if let users = data {
                    self.processFetchedUsers(users)
                }
            }
        }
    }
    
    private func processFetchedUsers(_ users: [User]) {
        var userCellViewModel = [UserCellViewModel]()
        for user in users {
            userCellViewModel.append(generateCellViewModel(user))
        }
        self.cellViewModels = userCellViewModel
    }
    
    // Fetching cell's viewmodel
    func fetchCellViewModel( at indexPath: IndexPath ) -> UserCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    // Creating cell's viewmodel
    func generateCellViewModel(_ user: User) -> UserCellViewModel {
        
        return UserCellViewModel(
            id: user.id,
            email: user.email,
            firstName:user.firstName,
            lastName: user.lastName,
            avatar: user.avatar
        )
    }
}
