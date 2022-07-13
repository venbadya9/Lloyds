//
//  UserRepository.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

class UserRepository: IUserRepository {
    
    // MARK: Private Variables
    
    private let service: IUserService
    
    init(service: IUserService) {
        self.service = service
    }
    
    func makeServiceCallToFetchDetails(completion: @escaping DataResponse) {
        self.service.makeNetworkApiCall { (result: Result<UserDataListDTO, Error>) in
            switch result {
            case .success(let users):
                completion(.success(users.toDmoain()))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
