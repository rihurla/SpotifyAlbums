//
//  SceneDelegate.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let applicationTokenStorage = ApplicationTokenStorage()
    private let tokenProvider = TokenDataProvider()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        applicationTokenStorage.delete()
        window = UIWindow(windowScene: windowScene)
        let newReleasesViewController = ViewControllerFactory.makeViewController(.newReleasesViewController)
        window?.rootViewController = UINavigationController(rootViewController: newReleasesViewController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        applicationTokenStorage.delete()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

