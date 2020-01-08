//
//  User.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

struct User: Codable {
    let login: String
    let id: Int
    let avatar_url: String
    let name: String
}
