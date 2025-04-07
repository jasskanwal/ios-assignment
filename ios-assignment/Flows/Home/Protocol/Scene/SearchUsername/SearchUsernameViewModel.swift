//
//  SearchUsernameViewModel.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation

protocol SearchUsernameViewModelProtocol {
    var searchText: String { get set }
    var state: SearchUsernameViewState { get set }
}

class SearchUsernameViewModel: SearchUsernameViewModelProtocol, ObservableObject {
    @Published var searchText: String = ""
    @Published var state: SearchUsernameViewState = .idle

    private let homeDataService: HomeDataServiceProtocol
    
    init(homeDataService: HomeDataServiceProtocol) {
        self.homeDataService = homeDataService
    }
}

enum SearchUsernameViewState {
    case idle
    case result(GitHubUser)
    case error(String)
}
