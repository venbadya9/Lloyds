//
//  AppContainer.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 06/07/22.
//

import Foundation
import UIKit

class AppContainer {
    
    func load(on window: UIWindow?) {
        let module = UserModule(serviceManager: NetworkClient())
        if let viewController = module.generateViewController() {
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}
