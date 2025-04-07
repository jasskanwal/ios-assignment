//
//  ProfileViewAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

class ProfileViewAssembly {
    static func ProfileViewAssembly() -> ((GitHubUser,
                                           ((GitHubUser) -> Void)?,
                                           ((GitHubUser) -> Void)?) -> ProfileViewProtocol)? {
        return { user, onFollowerTap, onFollowingTap in
            let viewModel = ProfileViewModel(user: user)
            viewModel.onFollowersTapped = onFollowerTap
            viewModel.onFollowingTapped = onFollowingTap
            return ProfileView(viewModel: viewModel)
        }
    }
}
