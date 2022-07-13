//
//  UserUseCase.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

class UserUseCase: IUserUseCase {
    
    // MARK: Private Variables
    
    private let respository: IUserRepository
    
    init(respository: IUserRepository) {
        self.respository = respository
    }

    // MARK: Protocol Functions
    
    func fetchUserList(completion: @escaping DomainResponse) {
        return self.respository.makeServiceCallToFetchDetails { (result: Result<UserDomainListDTO, Error>) in
            switch result {
            case .success(let users):
                completion(.success(users.toPresentation()))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
