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
    let profileViewAssembly: ((GitHubUser,
                               ((GitHubUser) -> Void)?,
                               ((GitHubUser) -> Void)?) -> ProfileViewProtocol)?
    init(navigationController: Router,
         searchUsernameViewFactory: ((((GitHubUser) -> Void)?) -> SearchUsernameViewProtocol)?,
         profileViewAssembly: ((GitHubUser,
                                    ((GitHubUser) -> Void)?,
                                    ((GitHubUser) -> Void)?) -> ProfileViewProtocol)?) {
        self.searchUsernameViewFactory = searchUsernameViewFactory
        self.profileViewAssembly = profileViewAssembly
        
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
        guard let profileView = profileViewAssembly?(user,
                                                     showFollowers(for:),
                                                     showFollowing(for:)) as? ProfileView else {
            fatalError("profileView not resolved")
        }
        
        self.navigationController.present(profileView.toNavigable(with: "profile_\(user.login)"))
    }
    
    func showFollowers(for user: GitHubUser) {
    }
    
    func showFollowing(for user: GitHubUser) {
    }
}
