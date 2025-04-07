//
//  NetworkService.swift
//  Assignment
//
//  Created by Jaskirat Singh on 2024-06-05.
//

import Foundation

enum APIConfig {
    static let baseURL = "https://api.github.com"
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    func request<T: Codable>(using api: APIRouteable,
                                         completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: APIConfig.baseURL + api.path)else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = SessionManager.shared.createRequest(url: url, method: api.method, headers: nil)
        
        if let parameters = api.parameters {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.decodingFailed(CustomError(title: nil,
                                                                description: (error as NSError).description,
                                                                code: (error as NSError).code))))
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.log(request: urlRequest)
            self?.log(response: response as? HTTPURLResponse, data: data, error: error)
            if let error = error {
                completion(.failure(.requestFailed(CustomError(title: nil,
                                                               description: (error as NSError).description,
                                                               code: (error as NSError).code))))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(.requestFailed(CustomError(title: nil,
                                                                   description: errorResponse.message ?? "Something went wrong",
                                                                   code: errorResponse.code ?? 0))))
                }  catch {
                    completion(.failure(.decodingFailed(CustomError(title: nil,
                                                                    description: (error as NSError).description,
                                                                    code: (error as NSError).code))))
                }
            }
        }
        dataTask.resume()
    }
    
    private func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
    }
    
    private func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
        print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
            output += "\(urlString)"
            output += "\n\n"
        }
        if let statusCode =  response?.statusCode {
            output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }
}
