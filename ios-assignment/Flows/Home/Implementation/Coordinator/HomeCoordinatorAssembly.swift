//
//  HomeCoordinatorAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation

class HomeCoordinatorAssembly {
    static func homeCoordinatorFactory() -> ((Router) -> HomeCoordinatorProtocol) {
        return { router in
            HomeCoordinator(navigationController: router, 
                            searchUsernameViewFactory: SearchUsernameAssembly.SearchUsernameViewAssembly())
        }
    }
}
