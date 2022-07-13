//
//  IUserUseCase.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

protocol IUserUseCase {
    func fetchUserList(completion: @escaping DomainResponse)
}
