//
//  SearchUsernameAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

class SearchUsernameAssembly {
    static func SearchUsernameViewAssembly() -> (() -> SearchUsernameViewProtocol)? {
        return {
            SearchUsernameView(viewModel: SearchUsernameViewModel(homeDataService: HomeDataService.shared))
        }
    }
}
