//
//  GithubUser.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation

struct GitHubUser: Codable, Identifiable, Hashable {
    var id: String { login }
    let login: String
    let name: String?
    let avatar_url: String
    let bio: String?
    let followers: Int
    let following: Int
}
