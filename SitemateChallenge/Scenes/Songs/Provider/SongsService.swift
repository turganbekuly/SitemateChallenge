//
//  SongsService.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import Moya
import UIKit

public typealias JSON = [String: Any]
public typealias MCResult = Result<JSON, MoyaError>

protocol SongsServiceProtocol {
    func getLyrics(
        request: SongsDataFlow.GetSongs.Request,
        completion: @escaping (Result<JSON, MoyaError>) -> Void
    )
}

public final class SongsService: SongsServiceProtocol {

    // MARK: - Properties

    private let provider: MoyaProvider<SongsEndpoints>

    // MARK: - Init

    init(provider: MoyaProvider<SongsEndpoints>) {
        self.provider = provider
    }

    // MARK: - MarksServiceProtocol

    func getLyrics(
        request: SongsDataFlow.GetSongs.Request,
        completion: @escaping (Result<JSON, MoyaError>) -> Void
    ) {
        provider.request(.getSongLyrics(title: request.title, artist: request.artist)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299, 300...399:
                    self.handleSuccess(data: response.data, completion: completion)
                default:
                    self.handleError(data: response.data, completion: completion)
                }
            case let .failure(error):
                print(error)
            }
        }
    }


    private func handleSuccess(data: Data, completion: @escaping (Result<JSON, MoyaError>) -> Void) {
        guard let json = dataToJson(data: data) else {
            completion(.success([String: Any]()))
            return
        }

        completion(.success(json))
    }

    private func handleError(data: Data, completion: @escaping (MCResult) -> Void) {
        print(String(data: data, encoding: .utf8))
    }

    private func dataToJson(data: Data) -> [String: Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let json = jsonObject as? [String: Any] {
                return json
            } else if let json = jsonObject as? [[String: Any]] {
                return [
                    "data": json
                ]
            } else if let json = jsonObject as? [Any] {
                return [
                    "data": json
                ]
            }
            return nil
        } catch {
            return nil
        }
    }
}

