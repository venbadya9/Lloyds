//
//  UserRepository.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

// MARK: UserRepository Protocol

protocol UserRepository {
    func makeServiceCallToGetUsers(completion: @escaping CompletionHandler)
}
