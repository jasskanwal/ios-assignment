//
//  CoordinatorProtocol.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-04.
//

//
//  Coordinator.swift
//  Core
//
//  Created by Jaskirat Singh on 2024-07-04.
//

import Foundation
import UIKit
import SwiftUI

public protocol CoordinatorResult {
}

public protocol Coordinator: AnyObject {
    /// The navigation controller for the coordinator
    var navigationController: Router { get }

    /**
     The Coordinator takes control and activates itself.
     - Parameters:
     - animated: Set the value to true to animate the transition.
     Pass false if you are setting up a navigation controller before its view is displayed.

     */
    func start(animated: Bool)
    func start() -> AnyView
    /**
     Pops out the active View Controller from the navigation stack.
     - Parameters:
     - animated: Set this value to true to animate the transition.
     */

    /// Each Coordinator can have its own children coordinators
    var childCoordinators: [Coordinator] { get set }
    /**
     Adds the given coordinator to the list of children.
     - Parameters:
     - child: A coordinator.
     */
    func addChild(_ child: Coordinator?)
    /**
     Removes coordinator from the list of childern.
     - Parameters:
     - child: A coordinator.
     */
    func childDidFinish(_ child: Coordinator?)

    /**
     Tells the parent coordinator that given coordinator is done and should be removed from the list of children.
     - Parameters:
     - child: A coordinator.
     */
    var onFinish: ((Coordinator, CoordinatorResult) -> Void)? { get set }
}

public extension Coordinator {
    // MARK: - Coordinator Functions
    /**
     Appends the coordinator to the children array.
     - Parameters:
     - child: The child coordinator to be appended to the list.
     */
    func addChild(_ child: Coordinator?) {
        if let extractedChild = child {
            childCoordinators.append(extractedChild)
        }
    }

    /**
     Removes the child from children array.
     - Parameters:
     - child: The child coordinator to be removed from the list.
     */
    func childDidFinish(_ child: Coordinator?) {
        guard let index = childCoordinators
            .firstIndex(where: { $0 === child }) else {
            return
        }

        childCoordinators.remove(at: index)
    }
}
