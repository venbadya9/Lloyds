//
//  MockRepository.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

class MockRepository: IUserRepository {
    
    var userList: UserDomainListDTO?
    var error: Error?
    
    func makeServiceCallToFetchDetails(completion: @escaping DataResponse) {
        if let _ = error {
            completion(.failure(NetworkError.failed))
        } else if let userList = userList {
            completion(.success(userList))
        }
    }
}
