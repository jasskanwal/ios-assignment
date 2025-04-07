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
    
    enum UserListType {
        case followers
        case following
    }
    
    init(user: GitHubUser, 
         type: UserListType,
         onUserTapped: ((GitHubUser) -> Void)?) {
        self.user = user
        self.onUserTapped = onUserTapped
        self.type = type
    }
    
    func loadData() {
    }
}

enum FollowerFollowingListViewState {
    case loading
    case success([GitHubUser])
    case error(String)
}
