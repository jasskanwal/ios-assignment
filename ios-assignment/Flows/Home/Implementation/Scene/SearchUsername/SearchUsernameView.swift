//
//  SearchUsernameView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

struct SearchUsernameView: SearchUsernameViewProtocol, View {
    @State var viewModel: any SearchUsernameViewModelProtocol
    
    var body: some View {
        Text("Hello, World!")
    }
    
    init(viewModel: any SearchUsernameViewModelProtocol) {
        self.viewModel = viewModel
    }
}

#Preview {
    SearchUsernameView(viewModel: SearchUsernameViewModel(homeDataService: HomeDataService.shared))
}
