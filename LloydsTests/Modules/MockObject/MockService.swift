//
//  MockService.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

class MockService: IUserService {
    
    var userList: UserDataListDTO?
    var error: Error?
    
    func makeNetworkApiCall<T>(completion: @escaping Response<T>) where T : Decodable {
        if let _ = error {
            completion(.failure(NetworkError.failed))
        } else if let userList = userList {
            completion(.success(userList as! T))
        }
    }
}
