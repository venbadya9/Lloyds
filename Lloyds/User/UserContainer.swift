//
//  UserContainer.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 06/07/22.
//

import Foundation
import UIKit

class UserModule {
    
    private let serviceManager: NetworkClient
    
    init(serviceManager: NetworkClient) {
        self.serviceManager = serviceManager
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
    
    private func generateUserViewModel() -> UserViewModel {
        let viewModel = UserViewModelImpl(useCase: generateUserUseCase())
        return viewModel
    }
    
    private func generateUserUseCase() -> UserUseCase {
        let useCase = UserUseCaseImpl(repository: generateUserRepository())
        return useCase
    }
    
    private func generateUserRepository() -> UserRepository {
        let repository = UserRepositoryImpl(service: serviceManager)
        return repository
    }
}
