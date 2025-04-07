//
//  View+Extension.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

public extension View {
    func toNavigable() -> NavigableView {
        return NavigableView(identifier: String(describing: self),
                                view: AnyView(self))
    }

    func toNavigable(with customIdentifier: String) -> NavigableView {
        return NavigableView(identifier: customIdentifier,
                                view: AnyView(self))
    }

    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
