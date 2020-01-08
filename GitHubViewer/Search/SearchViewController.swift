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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Viewer"
    }
    
    override func loadView() {
        self.view = searchView
    }
}
