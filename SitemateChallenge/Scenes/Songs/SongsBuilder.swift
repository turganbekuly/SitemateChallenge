//
//  SongsBuilder.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

final class SongsBuilder {

    // MARK: Properties
    private let state: SongsViewController.State

    // MARK: Initialization
    init(state: SongsViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> UIViewController {
        let presenter = SongsPresenter()
        let interactor = SongsInteractor(presenter: presenter)
        let viewController = SongsViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
