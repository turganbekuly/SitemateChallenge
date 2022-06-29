//
//  SongsPresenter.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

protocol SongsPresentationLogic: AnyObject {
    func getlyrics(response: SongsDataFlow.GetSongs.Response)
}

final class SongsPresenter: SongsPresentationLogic {

    // MARK: - Properties

    public weak var viewController: SongsDisplayLogic?

    // MARK: - MarksPresentationLogic

    public func getlyrics(response: SongsDataFlow.GetSongs.Response) {
        var viewModel: SongsDataFlow.GetSongs.ViewModel
        defer { viewController?.displayLyrics(viewModel: viewModel) }

        switch response.result {
        case let .successful(model):
            viewModel = .init(state: .fetchLyricsSucceed(model))
        case let .failed(error):
            viewModel = .init(state: .fetchLyricsFailed(error))
        }
    }
}

