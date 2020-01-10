//
//  SearchInteractor.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Combine

protocol SearchInteractorProtocol {
    func search(user: String)
}

protocol SearchServiceProtocol {
    func search(user: String) -> AnyPublisher<User, Error>
}

protocol SearchPresenterProtocol {
    func onError(error: Error)
    func present(user: User)
}

enum SearchError: Error {
    case notFound
    case networkingError
}

class SearchInteractor: SearchInteractorProtocol {
    let service: SearchServiceProtocol
    let presenter: SearchPresenterProtocol
    var cancellable: Cancellable?
    
    init(service: SearchServiceProtocol, presenter: SearchPresenterProtocol) {
        self.service = service
        self.presenter = presenter
    }
    
    func search(user: String) {
        cancellable = service.search(user: user).sink(receiveCompletion: { result in
            switch result {
            case .failure(let error):
                self.presenter.onError(error: error)
                break
            case .finished:
                break
            }
        }) { user in
            self.presenter.present(user: user)
        }
    }
}
