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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                                               onUserTapped: nil))
}
