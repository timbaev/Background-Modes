//
//  AppDelegate.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Instance Properties

    private var backgroundFetchResult: ((UIBackgroundFetchResult) -> Void)?

    // MARK: -

    var window: UIWindow?

    // MARK: - Instance Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)

        NotificationCenter.default.addObserver(self, selector: #selector(self.didBackgroundFetchSuccess(_:)), name: .backgroundFetchSuccess, object: nil)
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationCenter.default.post(name: .backgroundFetch, object: Date())

        self.backgroundFetchResult = completionHandler
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: .backgroundFetchSuccess, object: nil)
    }
}

// MARK: -

extension AppDelegate {

    // MARK: - Instance Methods

    @objc private func didBackgroundFetchSuccess(_ notification: NSNotification) {
        self.backgroundFetchResult?(.newData)

        self.backgroundFetchResult = nil
    }
}

