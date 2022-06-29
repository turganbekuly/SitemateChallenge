//
//  Songs+DisplayLogic.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Foundation

extension SongsViewController: SongsDisplayLogic {
    func displayLyrics(viewModel: SongsDataFlow.GetSongs.ViewModel) {
        state = viewModel.state
    }
}
