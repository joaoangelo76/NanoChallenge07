//
//  API.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

class APIManager: ObservableObject{
    
    func fetch<T: Codable>(httpLink: String, object: T) async -> Result<T, FetchError> {
        
        guard let url = URL(string: httpLink) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedObject)
            } else {
                return .failure(.networkError(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
            }
        } catch let error as DecodingError {
            return .failure(.decodingError(error))
        } catch {
            return .failure(.networkError(error))
        }
    }
}
