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
    
    init(navigationController: Router,
         searchUsernameViewFactory: ((((GitHubUser) -> Void)?) -> SearchUsernameViewProtocol)?) {
        self.searchUsernameViewFactory = searchUsernameViewFactory
        
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
        
    }
}
