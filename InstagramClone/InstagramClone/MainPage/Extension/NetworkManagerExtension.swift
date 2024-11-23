//
//  NetworkManagerExtension.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import Foundation

// Extend NetworkManager with additional functionality
extension NetworkManager {
    
    // Perform API Request for a generic endpoint and parameters
    func performAPIRequest(endpoint: String, parameters: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString + endpoint) else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Error encoding parameters: \(error)")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with network request: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code: \(String(describing: response))")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                completion(true) // Success response from the server
            }
        }
        
        task.resume()
    }
}
