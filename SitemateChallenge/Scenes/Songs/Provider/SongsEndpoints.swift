//
//  SongsEndpoints.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Foundation
import Moya

enum SongsEndpoints {
    case getSongLyrics(title: String, artist: String)
}

extension SongsEndpoints: TargetType {
    var baseURL: URL {
        return Configurations.baseURL
    }

    var path: String {
        switch self {
        case .getSongLyrics(let title, let artist):
            return "v1/\(artist)/\(title)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getSongLyrics:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        let headers = [
            "Content-Type": "application/json",
            "Content-Length": "0"
        ]
        return headers
    }


}
