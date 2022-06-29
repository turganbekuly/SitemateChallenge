//
//  AppDelegate.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?

    private lazy var configurators: [ApplicationConfiguratorProtocol] = {
        [
            InterfaceConfigurator(window: window)
        ]
    }()

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        configurators.forEach { $0.configure(application, launchOptions: launchOptions) }

        return true
    }
}

