//
//  FollowerFollowingListView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import SwiftUI

struct FollowerFollowingListView: FollowerFollowingListViewProtocol, View {
    @StateObject var viewModel: FollowerFollowingListViewModel
    
    var body: some View {
        List {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let array):
                ForEach(array) { user in
                    Button {
                        viewModel.onUserTapped?(user)
                    } label: {
                        MiniProfileView(gitHubUser: user)
                    }
                }
            case .error(let string):
                Text(string)
                    .foregroundStyle(.red)
            }
        }
        .onAppear(perform: viewModel.loadData)
        .navigationTitle(viewModel.type == .followers ? "Followers" : "Following")
        .refreshable {
            self.viewModel.loadData()
        }
    }
    
    init(viewModel: FollowerFollowingListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    FollowerFollowingListView(viewModel: .init(user: .init(login: "login",
                                                           name: "name",
                                                           avatar_url: "avatar_url",
                                                           bio: nil,
                                                           followers: 4,
                                                           following: 6),
                                               type: .followers,
                                               onUserTapped: nil,
                                               homeDataService: HomeDataService.shared))
}
