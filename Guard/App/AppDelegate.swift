//
//  AppDelegate.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DefaultsManager.isPremiumShown = false
        
        configure()
        
        return true
    }
}

// MARK: - Private methods
extension AppDelegate {
    
    private func configure() {
        var configurator = AppDelegateConfigurator()
        
        let setupAnalyticsCommand = SetupAnalyticsCommand()
        configurator.add(command: setupAnalyticsCommand)
        
        configurator.configure()
    }
}
