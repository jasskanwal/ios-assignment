//
//  HomeCoordinator.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-06.
//

import Foundation
import SwiftUI

class HomeCoordinator: RootCoordinator, HomeCoordinatorProtocol {
    let searchUsernameViewFactory: (() -> SearchUsernameViewProtocol)?
    
    init(navigationController: Router,
         searchUsernameViewFactory: (() -> SearchUsernameViewProtocol)?) {
        self.searchUsernameViewFactory = searchUsernameViewFactory
        
        super.init(navigationController: navigationController)
    }

    override func start() -> AnyView {
        showSearchUsername()
    }
    
    func showSearchUsername() -> AnyView {
        guard let searchUsernameView = searchUsernameViewFactory?() as? SearchUsernameView else {
            fatalError("searchUsernameView not resolved")
        }
        
        return searchUsernameView.eraseToAnyView()
    }
}
