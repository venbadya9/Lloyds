//
//  MockNetworkManager.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

class MockNetworkManager: INetworkManager {
    
    var userList: UserDataListDTO?
    var error: Error?
    
    func request<T>(fromUrl url: URL, completion: @escaping Response<T>) where T : Decodable {
        if let _ = error {
            completion(.failure(NetworkError.failed))
        } else if let userList = userList {
            completion(.success(userList as! T))
        }
    }
}
