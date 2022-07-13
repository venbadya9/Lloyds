//
//  AppDIContainer.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation
import UIKit

class AppDIContainer {
    
    var networkManager: INetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func load(on window: UIWindow?) {
        let module = UserModule(networkManager: networkManager)
        if let viewController = module.generateViewController() {
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}

