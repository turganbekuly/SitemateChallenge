//
//  SongsResultsBuilder.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

final class SongsResultsBuilder {

    // MARK: Properties

    private let state: SongsResultsViewController.State

    // MARK: Initialization

    init(state: SongsResultsViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder

    func build() -> UIViewController {
        let viewController = SongsResultsViewController(state: state)
        return viewController
    }

}
