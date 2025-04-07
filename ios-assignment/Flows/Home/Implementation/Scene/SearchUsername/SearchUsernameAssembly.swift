//
//  SearchUsernameAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

class SearchUsernameAssembly {
    static func SearchUsernameViewAssembly() -> ((((GitHubUser) -> Void)?) -> SearchUsernameViewProtocol)? {
        return { onTap in
            let viewModel = SearchUsernameViewModel(homeDataService: HomeDataService.shared)
            viewModel.onUserProfileTap = onTap
            return SearchUsernameView(viewModel: viewModel)
        }
    }
}
