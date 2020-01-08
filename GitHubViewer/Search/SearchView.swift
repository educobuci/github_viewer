//
//  SearchView.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let margin = 16

    lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let view = UIButton()
        view.setTitle("Search", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        // Build view hierarchy
        addSubview(searchTextField)
        addSubview(searchButton)
        // Setup constraints
        searchTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().inset(margin)
        }
        searchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(margin)
        }
        // Additional configuration
        backgroundColor = .white
    }
}
