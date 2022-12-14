//
//  SceneDelegate.swift
//  AEDFinderiOS
//
//  Created by 이동희 on 2022/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        
        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()
        
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

