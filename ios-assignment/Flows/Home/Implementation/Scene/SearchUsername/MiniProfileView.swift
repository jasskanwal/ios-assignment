//
//  MiniProfileView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import SwiftUI

struct MiniProfileView: View {
    let gitHubUser: GitHubUser
    var body: some View {
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
    }
}
