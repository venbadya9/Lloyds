//
//  UserContainer.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 06/07/22.
//

import Foundation
import UIKit

class UserModule {
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func generateViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserListVC") as? UserListVC  else {
            fatalError()
        }
        viewController.viewModel = generateUserViewModel()
        viewController.viewModel?.output = viewController
        return viewController
    }
    
    private func generateUserViewModel() -> IUserViewModel {
        let viewModel = UserViewModel(useCase: generateUserUseCase())
        return viewModel
    }
    
    private func generateUserUseCase() -> IUserUseCase {
        let useCase = UserUseCase(respository: generateUserRepository())
        return useCase
    }
    
    private func generateUserRepository() -> IUserRepository {
        let repository = UserRepository(service: createUserService())
        return repository
    }
    
    private func createUserService() -> IUserService {
        let service = UserService(networkManager: networkManager)
        return service
    }
}
