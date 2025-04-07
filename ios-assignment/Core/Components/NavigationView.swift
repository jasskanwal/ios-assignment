//
//  NavigationView.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

public struct NavigationView<Content: View>: View {
    @ObservedObject private var nav: Router
    @ViewBuilder
    let content: () -> Content

    public init(nav: Router, content: @escaping () -> Content) {
        self.nav = nav
        self.content = content
    }

    public var body: some View {
        NavigationStack(path: $nav.navigableViews) {
            content()
        }
    }
}

#Preview {
    NavigationView(nav: Router()) {
        Text("Hello")
    }
}
