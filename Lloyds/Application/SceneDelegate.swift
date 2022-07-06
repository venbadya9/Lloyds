//
//  SceneDelegate.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 30/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appContainer = AppContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        appContainer.load(on: window)
    }
}

