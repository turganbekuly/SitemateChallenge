//
//  InterfaceConfigurator.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

protocol ApplicationConfiguratorProtocol {
    func configure(
        _ application: UIApplication?,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
}

final class InterfaceConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Properties

    private var window: UIWindow?

    // MARK: - Init

    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        guard let window = window else {
            fatalError("Window not found")
        }

        let vc = SongsBuilder(state: .initial).build()
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
