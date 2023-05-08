//
//  SceneDelegate.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 02/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var adsRouter: AdsRouter?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let adsFetchingService = AdsFetchingService()
        
        adsRouter = AdsRouter(environement: .init(adsFetchingService: adsFetchingService),
                              rootTransition: EmptyTransition())

        guard let windowScene = (scene as? UIWindowScene),
              let rootViewController = adsRouter?.makeRootViewController() else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_: UIScene) {}
    func sceneDidBecomeActive(_: UIScene) {}
    func sceneWillResignActive(_: UIScene) {}
    func sceneWillEnterForeground(_: UIScene) {}
    func sceneDidEnterBackground(_: UIScene) {}
}
