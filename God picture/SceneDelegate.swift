//
//  SceneDelegate.swift
//  God picture
//
//  Created by Данил Менделев on 16.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window = window
        window.makeKeyAndVisible()
        Sound.shared.playMusic()
    }



}

