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
                if let name = gitHubUser.name {
                    Text(name)
                        .font(.headline)
                    Text("@\(gitHubUser.login)")
                        .foregroundColor(.gray)
                } else {
                    Text("@\(gitHubUser.login)")
                        .font(.headline)
                }
                
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}
