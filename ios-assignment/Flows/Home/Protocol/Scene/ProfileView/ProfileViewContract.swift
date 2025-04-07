//
//  ProfileViewContract.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation

protocol ProfileViewProtocol {
}

protocol ProfileViewModelProtocol {
    var user: GitHubUser { get }
    
    
    var onFollowersTapped: ((GitHubUser) -> Void)? { get set }
    var onFollowingTapped: ((GitHubUser) -> Void)? { get set }
}

class ProfileViewModel: ProfileViewModelProtocol, ObservableObject {
    internal let user: GitHubUser
    var onFollowersTapped: ((GitHubUser) -> Void)?
    var onFollowingTapped: ((GitHubUser) -> Void)?
    
    private let homeDataService: HomeDataServiceProtocol
    @Published var state: ProfileViewState = .loading

    init(user: GitHubUser, homeDataService: HomeDataServiceProtocol) {
        self.user = user
        self.homeDataService = homeDataService
    }
    
    func followersTapped() {
        self.onFollowersTapped?(user)
    }
    
    func followingTapped() {
        self.onFollowingTapped?(user)
    }
    
    func onLoad() {
        guard !user.login.isEmpty else {
            return
        }
        homeDataService.fetchUser(username: user.login) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.state = .success(user)
                case .failure:
                    self?.state = .error("User not found")
                }
            }
        }
    }
}

enum ProfileViewState: Equatable {
    case loading
    case success(GitHubUser)
    case error(String)
}
