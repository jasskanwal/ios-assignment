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
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: viewModel.user.avatar_url)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())

                    Text(viewModel.user.name ?? "No Name")
                        .font(.title)
                        .bold()
                    Text("@\(viewModel.user.login)")
                        .foregroundColor(.gray)
                    Text(viewModel.user.bio ?? "No bio")
                        .multilineTextAlignment(.center)
                        .padding()

                    HStack(spacing: 40) {
                        Button {
                            viewModel.followersTapped()
                        } label: {
                            VStack {
                                Text("\(viewModel.user.followers)")
                                    .bold()
                                Text("Followers")
                            }
                        }

                        Button {
                            viewModel.followingTapped()
                        } label: {
                            VStack {
                                Text("\(viewModel.user.following)")
                                    .bold()
                                Text("Following")
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.user.login)
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
