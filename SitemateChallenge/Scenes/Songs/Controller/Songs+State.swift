//
//  Songs+State.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Foundation
import Moya

extension SongsViewController {
    enum State {
        case initial
        case fetchLyricsSucceed(String)
        case fetchLyricsFailed(MoyaError)
    }

    func updateState() {
        switch state {
        case .initial:
            break
        case let .fetchLyricsSucceed(lyrics):
            guard let viewController = searchController.searchResultsController as? SongsResultsViewController else { return }
            viewController.lyrics = lyrics
        case .fetchLyricsFailed:
            guard let viewController = searchController.searchResultsController as? SongsResultsViewController else { return }
            viewController.lyrics = ""
        }
    }
}
