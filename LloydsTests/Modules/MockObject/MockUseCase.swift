//
//  MockUseCase.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

class MockUseCase: IUserUseCase {
    
    var userList: UserList?
    var error: Error?
    
    func fetchUserList(completion: @escaping DomainResponse) {
        if let _ = error {
            completion(.failure(NetworkError.failed))
        } else if let userList = userList {
            completion(.success(userList))
        }
    }
}
