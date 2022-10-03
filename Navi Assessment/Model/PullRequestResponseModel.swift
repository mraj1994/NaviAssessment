//
//  PullRequestResponseModel.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import Foundation

struct PullRequestResponseModel: Codable {
    let state: String?
    let title: String?
    let user: User?
    let createdAt, closedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case state, title, user
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}


// MARK: - User
struct User: Codable {
    let login: String?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case login
    }
}
