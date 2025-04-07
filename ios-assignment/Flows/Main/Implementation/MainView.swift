//
//  MainView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

struct MainView<Content: View>: View, MainViewProtocol {
    @ObservedObject private var nav: Router
    let content: () -> Content

    init(nav: Router,
         content: @escaping () -> Content) {

        self.content = content
        self.nav = nav
    }

    var body: some View {
        NavigationView(nav: nav) {
            content()
                .navigationDestination(for: NavigableView.self) {
                    $0.view
                }
        }
    }
}

#Preview {
    MainView(nav: Router()) {
        EmptyView()
    }
}
