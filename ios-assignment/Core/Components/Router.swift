//
//  Router.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

public final class Router: ObservableObject {
    @Published public var navigableViews: [NavigableView] = []

    public init() {
    }
}

extension Router: Routable {
    public func present(_ view: NavigableView) {
        navigableViews.append(view)
    }

    public func popToRoot() {
        navigableViews.removeAll()
    }

    public func pop() {
        navigableViews.removeLast()
    }
}
