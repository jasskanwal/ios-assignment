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
    var onUserProfileTap: ((GitHubUser) -> Void)? { get set }
    
    func onTextFieldSubmit()
}

class SearchUsernameViewModel: SearchUsernameViewModelProtocol, ObservableObject {
    var onUserProfileTap: ((GitHubUser) -> Void)?
    @Published var searchText: String = ""
    @Published var state: SearchUsernameViewState = .idle

    private let homeDataService: HomeDataServiceProtocol
    
    init(homeDataService: HomeDataServiceProtocol) {
        self.homeDataService = homeDataService
    }
    
    func onTextFieldSubmit() {
        guard !searchText.isEmpty else {
            return
        }
        self.state = .loading
        homeDataService.fetchUser(username: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.state = .result(user)
                case .failure:
                    self?.state = .error("User not found")
                }
            }
        }
    }
}

enum SearchUsernameViewState: Equatable {
    case idle
    case loading
    case result(GitHubUser)
    case error(String)
}
