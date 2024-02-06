//
//  AppDelegate.swift
//  DailyTask
//
//  Created by Daniel Kimani on 10/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //self.window?.backgroundColor = .systemBackground
        self.window?.backgroundColor = UIColor(named: "backgroundColor")
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
        //self.window?.rootViewController = SplashViewController()
         return true
    }
    


}

