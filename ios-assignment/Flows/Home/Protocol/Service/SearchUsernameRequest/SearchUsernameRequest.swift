//
//  SearchUsernameRequest.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-06.
//

import Foundation

struct SearchUsernameRequest: APIRouteable {
    let userName: String
    var path: String {
        "/users/\(userName)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Codable? {
        nil
    }
    
    init(userName: String) {
        self.userName = userName
    }
}
