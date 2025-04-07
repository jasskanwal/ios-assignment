//
//  HomeDataService.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-07.
//

import Foundation
class HomeDataService: HomeDataServiceProtocol {
    let networkService: NetworkServiceProtocol
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
