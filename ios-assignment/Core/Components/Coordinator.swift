//
//  Coordinator.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

open class RootCoordinator: Coordinator {
    public let navigationController: Router

    open func start(animated: Bool) {
        fatalError("UIKit start not implemented")
    }

    open func start() -> AnyView {
        fatalError("Swift UI start not implemented")
    }

    public var childCoordinators: [any Coordinator] = []

    public var onFinish: ((any Coordinator, any CoordinatorResult) -> Void)?

    public init(navigationController: Router) {
        self.navigationController = navigationController
    }

    deinit {
        debugPrint("\(String(describing: self)) deinit called")
    }
}
