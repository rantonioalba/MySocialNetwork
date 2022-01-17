//
//  AppDelegate.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 08/01/22.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let authController = AuthController(nibName: "AuthController", bundle: nil)
//
//        let navController = UINavigationController(rootViewController: authController)
//
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        
        let loginController = LoginController(nibName: "LoginController", bundle: nil)

        let navController = UINavigationController(rootViewController: loginController)

        window?.rootViewController = loginController
        window?.makeKeyAndVisible()
        
        
//        let customTabBarController = CustomTabBarController()
//
//        customTabBarController.setupView()
//
//        window?.rootViewController = customTabBarController
//        window?.makeKeyAndVisible()
        
        return true
    }
}

