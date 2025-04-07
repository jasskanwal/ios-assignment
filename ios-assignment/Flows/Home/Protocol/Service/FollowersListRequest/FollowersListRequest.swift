//
//  FollowersListRequest.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import Foundation

struct FollowersListRequest: APIRouteable {
    let userName: String
    var path: String {
        "/users/\(userName)/followers"
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
