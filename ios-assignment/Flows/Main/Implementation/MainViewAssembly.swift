//
//  MainViewAssembly.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation
import SwiftUI

class MainViewAssembly {
    static func mainViewFactory() -> ((_ nav: Router,
                                       _ rootView: @escaping (() -> AnyView)) -> MainViewProtocol) {
        return { nav,
            rootView in
            return MainView(nav: nav, content: rootView)
        }
    }
}
