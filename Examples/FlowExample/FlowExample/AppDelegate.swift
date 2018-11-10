//
//  AppDelegate.swift
//  FlowExample
//
//  Created by Martin Nygren on 15/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() {
            let navController = UINavigationController(rootViewController: viewController)
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
            return true
        }

        return false
    }
}

