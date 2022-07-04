//
//  UserUseCase.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

// MARK: UserUseCase Protocol

protocol UserUseCase {
    func fetchUsers(completion: @escaping CompletionHandler)
}
