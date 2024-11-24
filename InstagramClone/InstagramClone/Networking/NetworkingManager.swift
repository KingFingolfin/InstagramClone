//
//  NetworkingManager.swift
//  Assignmet27-InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import UIKit
 
protocol NetworkManagerProtocol {
    func fetchData(completionHandler: @escaping (Result<[Post], NetworkError>) -> Void)
}
 
class NetworkManager: NetworkManagerProtocol {
    
    let urlString = "http://localhost:3000/v1/v1/geographies/:geo-id/media/recent"
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completionHandler: @escaping (Result<[Post], NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("erroor with fethching data")
                completionHandler(.failure(.requestFailed(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code: \(String(describing: response))")
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completionHandler(.failure(.unexpectedStatusCode(statusCode)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            do {
                let userData = try JSONDecoder().decode(APIResponse.self, from: data)
                completionHandler(.success(userData.data))
            } catch {
                completionHandler(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}
