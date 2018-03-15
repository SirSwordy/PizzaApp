//
//  AppDelegate.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 11/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        CartManager.sharedInstance().loadCart()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        CartManager.sharedInstance().loadCart()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CartManager.sharedInstance().saveCart()
    }
}

