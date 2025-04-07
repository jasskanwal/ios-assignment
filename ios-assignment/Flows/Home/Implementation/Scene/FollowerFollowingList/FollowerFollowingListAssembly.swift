//
//  FollowerFollowingListAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import Foundation

class FollowerFollowingListAssembly {
    static func FollowerFollowingListAssembly() -> ((GitHubUser,
                                                     FollowerFollowingListViewModel.UserListType,
                                                     ((GitHubUser) -> Void)?) -> FollowerFollowingListViewProtocol)? {
        return { user, type, onTap in
            let viewModel = FollowerFollowingListViewModel(user: user,
                                                           type: type,
                                                           onUserTapped: onTap,
                                                           homeDataService: HomeDataService.shared)
            return FollowerFollowingListView(viewModel: viewModel)
        }
    }
}
