//
//  FollowerFollowingListContract.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import Foundation

protocol FollowerFollowingListViewProtocol {
}

protocol FollowerFollowingListViewModelProtocol {
    var user: GitHubUser { get }
    var onUserTapped: ((GitHubUser) -> Void)? { get }
    var type: FollowerFollowingListViewModel.UserListType { get }
}

class FollowerFollowingListViewModel: FollowerFollowingListViewModelProtocol, ObservableObject {
    let user: GitHubUser
    let onUserTapped: ((GitHubUser) -> Void)?
    let type: UserListType
    @Published var state: FollowerFollowingListViewState = .loading
    
    let homeDataService: HomeDataServiceProtocol
    
    enum UserListType {
        case followers
        case following
    }
    
    init(user: GitHubUser, 
         type: UserListType,
         onUserTapped: ((GitHubUser) -> Void)?,
         homeDataService: HomeDataServiceProtocol) {
        self.user = user
        self.onUserTapped = onUserTapped
        self.type = type
        self.homeDataService = homeDataService
    }
    
    func loadData() {
        switch self.type {
        case .followers:
            self.loadFollowers()
        case .following:
            self.loadFollowing()
        }
    }
    
    private func loadFollowers() {
        guard let followers = user.followers, followers > 0 else {
            self.state = .error("No followers")
            return
        }
        self.homeDataService.fetchfollowersList(username: user.login) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.state = .success(users)
                case .failure:
                    self?.state = .error("Something went wrong")
                }
            }
        }
    }
    
    private func loadFollowing() {
        guard let following = user.following, following > 0 else {
            self.state = .error("No following")
            return
        }
        self.homeDataService.fetchfollowingList(username: user.login) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.state = .success(users)
                case .failure:
                    self?.state = .error("Something went wrong")
                }
            }
        }
    }
}

enum FollowerFollowingListViewState {
    case loading
    case success([GitHubUser])
    case error(String)
}
