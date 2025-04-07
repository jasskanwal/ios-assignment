//
//  HomeDataServiceProtocol.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-07.
//

import Foundation

protocol HomeDataServiceProtocol {
    func fetchUser(username: String, completion: @escaping (Result<GitHubUser, NetworkError>) -> Void)
    func fetchfollowersList(username: String, completion: @escaping (Result<[GitHubUser], NetworkError>) -> Void)
    func fetchfollowingList(username: String, completion: @escaping (Result<[GitHubUser], NetworkError>) -> Void)
}

extension HomeDataServiceProtocol {
}
