//
//  GitHubService.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Foundation
import Combine

protocol DataDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

class GitHubService: SearchServiceProtocol {
    let baseURL = "https://api.github.com/users/"
    let session: URLSession
    let decoder: DataDecoderProtocol
    var publisher: AnyPublisher<User, Error>?
    
    init(session: URLSession, decoder: DataDecoderProtocol) {
        self.session = session
        self.decoder = decoder
    }
    
    func search(user: String) -> AnyPublisher<User, Error> {
        let url = URL(string: "\(baseURL)\(user)")!
        publisher = session.dataTaskPublisher(for: url).tryMap { data, response in
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    switch httpResponse.statusCode {
                    case 200:
                        return try self.decoder.decode(User.self, from: data)
                    case 404:
                        throw SearchError.notFound
                    default:
                        throw SearchError.networkingError
                    }
                } catch {
                    throw error
                }
            } else {
                throw SearchError.networkingError
            }
        }.eraseToAnyPublisher()
        return publisher!
    }
}
