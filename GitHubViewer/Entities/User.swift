//
//  User.swift
//  GitHubViewer
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

struct User: Codable, Equatable {
    let login: String
    let id: Int
    let avatarUrl: String
    let name: String
    
    private enum CodingKeys : String, CodingKey {
        case login, id, avatarUrl = "avatar_url", name
    }
}
