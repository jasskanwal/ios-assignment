//
//  FollowingListRequest.swift
//  ios-assignment
//
//  Created by Jaskirat Singh on 2025-04-07.
//

import Foundation

struct FollowingListRequest: APIRouteable {
    let userName: String
    let page: Int
    var path: String {
        "/users/\(userName)/following?page=\(page)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Codable? {
        nil
    }
    
    init(userName: String, page: Int) {
        self.userName = userName
        self.page = page
    }
}
