//
//  ApplicationFactory.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/9/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import UIKit

class ApplicationFactory {
    lazy var service = GitHubService(session: URLSession.shared, decoder: JSONDecoder())
    
    func createRootViewController() -> UINavigationController {
        let searchViewController = SearchViewController(nibName: nil, bundle: nil)
        searchViewController.interactor = SearchInteractor(service: service, presenter: SearchPresenter(view: searchViewController))
        let navigationController = UINavigationController(rootViewController: searchViewController)
        return navigationController
    }
}

extension JSONDecoder: DataDecoderProtocol { }
