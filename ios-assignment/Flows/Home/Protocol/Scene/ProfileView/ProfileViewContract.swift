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
    let user: GitHubUser
    var onFollowersTapped: ((GitHubUser) -> Void)?
    var onFollowingTapped: ((GitHubUser) -> Void)?

    init(user: GitHubUser) {
        self.user = user
    }
    
    func followersTapped() {
        self.onFollowersTapped?(user)
    }
    
    func followingTapped() {
        self.onFollowingTapped?(user)
    }
}
