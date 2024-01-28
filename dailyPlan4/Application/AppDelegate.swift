//
//  AppDelegate.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if #available(iOS 13, *) {
        } else {
            self.window = UIWindow()
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

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
