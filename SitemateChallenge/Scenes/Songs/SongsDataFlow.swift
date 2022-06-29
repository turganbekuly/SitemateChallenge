//
//  SongsDataFlow.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Foundation
import Moya

enum SongsDataFlow { }

extension SongsDataFlow {
    enum GetSongs {
        struct Request {
            let title: String
            let artist: String
        }
        struct Response {
            let result: GetSongsResult
        }
        struct ViewModel {
            var state: SongsViewController.State
        }
    }

    enum GetSongsResult {
        case successful(model: String)
        case failed(error: MoyaError)
    }
}
