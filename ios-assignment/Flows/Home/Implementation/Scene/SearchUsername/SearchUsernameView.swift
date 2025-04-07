//
//  SearchUsernameView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

struct SearchUsernameView: SearchUsernameViewProtocol, View {
    @StateObject var viewModel: SearchUsernameViewModel
    @FocusState var focusState: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Type Username", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($focusState)
                .onSubmit(viewModel.onTextFieldSubmit)
                .onChange(of: viewModel.searchText) { _, _ in
                    self.viewModel.state = .idle
                }
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .result(let gitHubUser):
                Button {
                    viewModel.onUserProfileTap?(gitHubUser)
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: gitHubUser.avatar_url)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(gitHubUser.name ?? "No Name")
                                .font(.headline)
                            Text("@\(gitHubUser.login)")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                }
            case .error(let string):
                Text(string)
                    .foregroundStyle(.red)
            }
            
            Spacer()
        }
        .navigationTitle("Search")
        .onAppear {
            guard !focusState else {
                return
            }
            focusState.toggle()
        }
    }
    
    init(viewModel: SearchUsernameViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    SearchUsernameView(viewModel: SearchUsernameViewModel(homeDataService: HomeDataService.shared))
}
