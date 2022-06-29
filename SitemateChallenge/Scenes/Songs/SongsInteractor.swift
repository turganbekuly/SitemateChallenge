//
//  SongsInteractor.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Moya

protocol SongsBusinessLogic {
    func getLyrics(request: SongsDataFlow.GetSongs.Request)
}

public final class SongsInteractor: SongsBusinessLogic {

    // MARK: - Properties

    private let presenter: SongsPresentationLogic
    private let service: SongsServiceProtocol

    // MARK: - Initialization

    init(
        presenter: SongsPresentationLogic,
        service: SongsServiceProtocol = SongsService(provider: MoyaProvider<SongsEndpoints>())
    ) {
        self.presenter = presenter
        self.service = service
    }

    // MARK: - MarksBusinessLogic

    func getLyrics(request: SongsDataFlow.GetSongs.Request) {
        service.getLyrics(request: request) { [weak self] in
            switch $0 {
            case let .success(json):
                if let json = json["lyrics"] as? String {
                    self?.presenter.getlyrics(response: .init(result: .successful(model: json)))
                } else {
                    self?.presenter.getlyrics(response: .init(result: .failed(error: .requestMapping("Error"))))
                }
            case let .failure(error):
                self?.presenter.getlyrics(response: .init(result: .failed(error: error)))
            }
        }
    }

}

