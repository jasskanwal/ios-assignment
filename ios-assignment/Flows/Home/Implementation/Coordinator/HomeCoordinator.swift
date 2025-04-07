//
//  HomeCoordinator.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-06.
//

import Foundation
import SwiftUI

class HomeCoordinator: RootCoordinator, HomeCoordinatorProtocol {
    let searchUsernameViewFactory: ((((GitHubUser) -> Void)?) -> SearchUsernameViewProtocol)?
    let profileViewFactory: ((GitHubUser,
                               ((GitHubUser) -> Void)?,
                               ((GitHubUser) -> Void)?) -> ProfileViewProtocol)?
    let followerFollowingListFactory: ((GitHubUser,
                                        FollowerFollowingListViewModel.UserListType,
                                        ((GitHubUser) -> Void)?) -> FollowerFollowingListViewProtocol)?
    init(navigationController: Router,
         searchUsernameViewFactory: ((((GitHubUser) -> Void)?) -> SearchUsernameViewProtocol)?,
         profileViewFactory: ((GitHubUser,
                                    ((GitHubUser) -> Void)?,
                                    ((GitHubUser) -> Void)?) -> ProfileViewProtocol)?,
         followerFollowingListFactory: ((GitHubUser,
                                             FollowerFollowingListViewModel.UserListType,
                                             ((GitHubUser) -> Void)?) -> FollowerFollowingListViewProtocol)?) {
        self.searchUsernameViewFactory = searchUsernameViewFactory
        self.profileViewFactory = profileViewFactory
        self.followerFollowingListFactory = followerFollowingListFactory
        
        super.init(navigationController: navigationController)
    }

    override func start() -> AnyView {
        showSearchUsername()
    }
    
    func showSearchUsername() -> AnyView {
        let onUserNameTap: ((GitHubUser) -> Void) = showUserProfile(using:)
        guard let searchUsernameView = searchUsernameViewFactory?(onUserNameTap) as? SearchUsernameView else {
            fatalError("searchUsernameView not resolved")
        }
        
        return searchUsernameView.eraseToAnyView()
    }
    
    func showUserProfile(using user: GitHubUser) {
        guard let profileView = profileViewFactory?(user,
                                                     showFollowers(for:),
                                                     showFollowing(for:)) as? ProfileView else {
            fatalError("profileView not resolved")
        }
        
        self.navigationController.present(profileView.toNavigable(with: "profile_\(user.login)"))
    }
    
    func showFollowers(for user: GitHubUser) {
        guard let followerFollowingListView = followerFollowingListFactory?(user,
                                                                            .followers,
                                                                            showUserProfile(using:)) as? FollowerFollowingListView else {
            fatalError("followerFollowingListView not resolved")
        }
        
        self.navigationController.present(followerFollowingListView.toNavigable(with: "follower_\(user.login)_\(UUID())"))
    }
    
    func showFollowing(for user: GitHubUser) {
        guard let followerFollowingListView = followerFollowingListFactory?(user,
                                                                            .following,
                                                                            showUserProfile(using:)) as? FollowerFollowingListView else {
            fatalError("followerFollowingListView not resolved")
        }
        
        self.navigationController.present(followerFollowingListView.toNavigable(with: "following_\(user.login)_\(UUID())"))
    }
}
