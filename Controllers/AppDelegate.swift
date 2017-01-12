//
//  AppDelegate.swift
//  Lent '17
//
//  Created by Paul Kirk Adams on 1/12/17.
//  Copyright © 2017 Paul Kirk Adams. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(red: 100/255, green: 15/255, blue: 125/255, alpha: 1) // Hex #640F7D
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        Thread.sleep(forTimeInterval: 1.5)
        Fabric.with([Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()
        return true
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
