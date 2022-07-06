//
//  UserRepositiryImpl.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation

class UserRepositoryImpl: UserRepository {
    
    // MARK: Private Variables
    
    private let service: NetworkClient
    
    // MARK: Object Lifecycle
    
    init(service: NetworkClient) {
        self.service = service
    }
    
    // MARK: Protocol Functions
    
    func makeServiceCallToGetUsers(url: URL?, completion: @escaping (Result<UserList, APIError>) -> Void) {
        return service.getApiData(requestUrl: url ?? Endpoints.userListUrl, resultType: UserList.self, completion: completion)
    }
}
