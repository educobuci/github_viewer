//
//  SearchPresenter.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/9/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Combine

protocol SearchViewProtocol {
    func displayMessage(title: String, message: String)
}

class SearchPresenter: SearchPresenterProtocol {
    let view: SearchViewProtocol
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func present(user: User) {
        view.displayMessage(title: user.login, message: user.name)
    }
    
    func onError(error: Error) {
        switch error {
        case SearchError.notFound:
            view.displayMessage(title: "Error", message: "User not found")
        default:
            view.displayMessage(title: "Error", message: "An unknown error has occurred")
        }
    }
}
