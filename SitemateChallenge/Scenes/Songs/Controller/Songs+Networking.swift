//
//  Songs+Networking.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Foundation

extension SongsViewController {
    public func getLyrics(title: String, artist: String) {
        interactor.getLyrics(request: .init(title: title, artist: artist))
    }
}
