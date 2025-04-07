//
//  HomeDataService.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-07.
//

import Foundation
class HomeDataService: HomeDataServiceProtocol {
    static let shared = HomeDataService(networkService: NetworkService.shared)
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUser(username: String, completion: @escaping (Result<GitHubUser, NetworkError>) -> Void) {
        let request = SearchUsernameRequest(userName: username)
        self.networkService.request(using: request, completion: completion)
    }
    
    func fetchfollowersList(username: String,
                            page: Int,
                            completion: @escaping (Result<[GitHubUser], NetworkError>) -> Void) {
        let request = FollowersListRequest(userName: username, page: page)
        self.networkService.request(using: request, completion: completion)
    }
    
    func fetchfollowingList(username: String, 
                            page: Int,
                            completion: @escaping (Result<[GitHubUser], NetworkError>) -> Void) {
        let request = FollowingListRequest(userName: username, page: page)
        self.networkService.request(using: request, completion: completion)
    }
}
