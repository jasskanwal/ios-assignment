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
        if viewModel.state == .loading {
            ProgressView()
        }
            ScrollView {
                switch viewModel.state {
                case .loading:
                    EmptyView()
                case .success(let gitHubUser):
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: gitHubUser.avatar_url)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())

                        Text(gitHubUser.name ?? "No Name")
                            .font(.title)
                            .bold()
                        Text("@\(gitHubUser.login)")
                            .foregroundColor(.gray)
                        Text(gitHubUser.bio ?? "No bio")
                            .multilineTextAlignment(.center)
                            .padding()

                        HStack(spacing: 40) {
                            Button {
                                viewModel.followersTapped()
                            } label: {
                                VStack {
                                    Text("\(gitHubUser.followers ?? 0)")
                                        .bold()
                                    Text("Followers")
                                }
                            }

                            Button {
                                viewModel.followingTapped()
                            } label: {
                                VStack {
                                    Text("\(gitHubUser.following ?? 0)")
                                        .bold()
                                    Text("Following")
                                }
                            }
                        }
                    }
                    .padding()
                case .error(let string):
                    Text(string).foregroundStyle(.red)
                }
               
            }
            .onAppear {
                viewModel.onLoad()
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
                                             following: 6), homeDataService: HomeDataService.shared))
}
