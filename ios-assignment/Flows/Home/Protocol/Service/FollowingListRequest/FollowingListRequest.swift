//
//  FollowingListRequest.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import Foundation

struct FollowingListRequest: APIRouteable {
    let userName: String
    var path: String {
        "/users/\(userName)/following"
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
