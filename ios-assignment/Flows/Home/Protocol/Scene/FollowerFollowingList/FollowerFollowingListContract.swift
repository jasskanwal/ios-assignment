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
    @Published var footerState: FollowerFollowingListFooterState = .idle

    private var page = 1
    
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
        self.state = .loading
        self.footerState = .idle
        self.page = 0
        makeServerCall()
    }
    
    func loadNextPage() {
        guard footerState == .loading else {
            return
        }
        page += 1
        makeServerCall()
    }
    
    func makeServerCall() {
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
            self.footerState = .idle
            return
        }
        self.homeDataService.fetchfollowersList(username: user.login, 
                                                page: page,
                                                completion: handleResponse(result:))
    }
    
    private func loadFollowing() {
        guard let following = user.following, following > 0 else {
            self.state = .error("No following")
            self.footerState = .idle
            return
        }
        self.homeDataService.fetchfollowingList(username: user.login,
                                                page: page,
                                                completion: handleResponse(result:))
    }
    
    func handleResponse(result: Result<[GitHubUser], NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let users):
                var existingList: [GitHubUser] = []
                switch self.state {
                case .success(let array):
                    existingList = array
                default: break
                }
                existingList.append(contentsOf: users)
                if users.count < 30 { // Default Page count is 30
                    self.footerState = .idle
                } else {
                    self.footerState = .loading
                }
                self.state = .success(existingList)
            case .failure:
                var existingList: [GitHubUser] = []
                switch self.state {
                case .success(let array):
                    existingList = array
                default: break
                }
                if existingList.count > 0 {
                    self.footerState = .errorFooter("Something went wrong")
                } else {
                    self.state = .error("Something went wrong")
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

enum FollowerFollowingListFooterState: Equatable {
    case idle
    case loading
    case errorFooter(String)
}
