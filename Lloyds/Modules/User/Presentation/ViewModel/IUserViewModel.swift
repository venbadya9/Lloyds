//
//  UserViewModel.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

// MARK: UserViewModel Protocol

protocol IUserViewModel {
    var users: [UserCellViewModel] { get set }
    func fetchUsers()
    var output: CallbackStatus? { get set }
}

// MARK: CallbackStatus Protocol

protocol CallbackStatus {
    func handleSuccess()
    func handleFailure(_ message: String)
}
