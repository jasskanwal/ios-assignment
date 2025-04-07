//
//  ios_assignmentApp.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import SwiftUI

@main
struct ios_assignmentApp: App {
    @ObservedObject var appCoordinator: AppCoordinator

    init() {
        self.appCoordinator  = AppCoordinatorAssembly.resolveAppCoordinator()
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator
                .start()
        }
    }
}
