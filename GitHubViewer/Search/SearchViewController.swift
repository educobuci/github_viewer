//
//  SearchViewController.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    lazy var searchView: SearchView = SearchView()
    var interactor: SearchInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Viewer"
        bindEvents()
    }
    
    override func loadView() {
        self.view = searchView
    }
    
    func bindEvents() {
        searchView.searchButton.addTarget(self, action: #selector(onSearch(_:)), for: .touchUpInside)
    }
    
    @objc func onSearch(_ sender: UIButton) {
        if let term = searchView.searchTextField.text {
            interactor?.search(term: term)
        }
    }
}
