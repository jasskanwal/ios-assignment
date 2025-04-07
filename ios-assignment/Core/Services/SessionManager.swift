//
//  SessionManager.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-05.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    func createRequest(url: URL, method: HTTPMethod, headers: [String: String]?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Add common headers
        
        urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "accept")
        
        return urlRequest
    }
}
