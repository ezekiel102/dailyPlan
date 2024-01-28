//
//  SceneDelegate.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import RealmSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm \(error)")
        }
    }
}
