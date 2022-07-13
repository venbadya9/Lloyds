//
//  UserService.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

class UserService: IUserService {
    
    // MARK: Private Variables
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func makeNetworkApiCall<T: Decodable>(completion: @escaping Response<T>) {
        self.networkManager.request(fromUrl: UserAPIEndpoints.userEndpoint, completion: completion)
    }
}
