//
//  MockAPIData.swift
//  Nano07Challenge
//
//  Created by João Victor Bernardes Gracês on 28/06/24.
//

import Foundation
import Foundation
import UIKit

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

class FetchMockData {
    func fetch<T: Codable>(httpLink: String, object: T.Type, session: URLSessionProtocol = URLSession.shared) async -> Result<T, FetchError> {
        guard let url = URL(string: httpLink), await UIApplication.shared.canOpenURL(url) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await session.data(from: url)
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
