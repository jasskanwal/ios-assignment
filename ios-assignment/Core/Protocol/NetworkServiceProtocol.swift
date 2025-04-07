//
//  NetworkServiceProtocol.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-05.
//

import Foundation

struct CustomError: LocalizedError {

    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

struct ErrorResponse: Codable {
    let code: Int?
    let error: Bool?
    let message: String?
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(CustomError)
    case invalidResponse
    case decodingFailed(CustomError)
    case unauthorised
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol NetworkServiceProtocol {
    func request<T: Codable>(using api: APIRouteable,
                             completion: @escaping (Result<T, NetworkError>) -> Void)
}

protocol APIRouteable {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Codable? { get }
}
