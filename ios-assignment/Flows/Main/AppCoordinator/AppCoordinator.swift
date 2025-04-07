//
//  AppCoordinator.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-04.
//

import Foundation
import SwiftUI

class AppCoordinator: RootCoordinator, AppCoordinatorProtocol, ObservableObject {
    
    var homeCoordinatorFactory: ((Router) -> HomeCoordinatorProtocol)?

    var mainViewFactory: ((_ nav: Router,
                           _ rootView: @escaping (() -> AnyView)) -> MainViewProtocol)?
    init(navigationController: Router,
         homeCoordinatorFactory: ((Router) -> HomeCoordinatorProtocol)?,
         mainViewFactory: ((_ nav: Router,
                            _ rootView: @escaping (() -> AnyView)) -> MainViewProtocol)?) {
        self.homeCoordinatorFactory = homeCoordinatorFactory
        self.mainViewFactory = mainViewFactory

        super.init(navigationController: navigationController)
    }

    override func start() -> AnyView {
        showMainScreen()
    }
    
    func startHomeFlow() -> AnyView {
        guard let homeCoordinator = self.homeCoordinatorFactory?(self.navigationController) else {
            fatalError("mainView not resolved")
        }
        self.addChild(homeCoordinator)
        homeCoordinator.onFinish = {[weak self] coordinator, _ in
            self?.childDidFinish(coordinator)
        }
        return homeCoordinator.start()
    }


    private func showMainScreen() -> AnyView {
        let rootView = startHomeFlow
        guard let mainView = mainViewFactory?(navigationController,
                                              rootView) as? MainView<AnyView> else {
            fatalError("mainView not resolved")
        }
        return mainView
            .eraseToAnyView()
    }
}
