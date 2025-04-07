//
//  ProfileView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

struct ProfileView: ProfileViewProtocol, View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    ProfileView(viewModel: .init(user: .init(login: "login",
                                             name: "name",
                                             avatar_url: "avatar_url",
                                             bio: nil,
                                             followers: 4,
                                             following: 6)))
}
