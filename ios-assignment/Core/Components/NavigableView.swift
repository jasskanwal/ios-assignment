//
//  NavigableView.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

public struct NavigableView: Navigable {
    public let id = UUID()
    public let identifier: String
    public let view: AnyView

    public init(identifier: String, view: AnyView) {
        self.identifier = identifier
        self.view = view
    }
    public init(view: AnyView) {
        self.identifier = String(describing: view.self)
        self.view = view
    }
}

public protocol Navigable: Identifiable, Hashable {}

extension Navigable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public protocol Routable {
    func present(_ view: NavigableView)
    func popToRoot()
    func pop()
}
