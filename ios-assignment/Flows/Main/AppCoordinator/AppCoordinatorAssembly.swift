//
//  AppCoordinatorAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

class AppCoordinatorAssembly {
    static func resolveAppCoordinator() -> AppCoordinator {
        return AppCoordinator(navigationController: Router(),
                              homeCoordinatorFactory: HomeCoordinatorAssembly.homeCoordinatorFactory(),
                              mainViewFactory: MainViewAssembly.mainViewFactory())
    }
}
 
