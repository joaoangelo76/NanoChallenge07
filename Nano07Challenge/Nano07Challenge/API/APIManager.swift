//
//  API.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import Foundation

enum FetchError: Error, LocalizedError, Equatable{
    case invalidURL
    
    case networkError(Error)
    
    case decodingError(DecodingError)
    
    case missingRequiredFields(String)
    
    case invalidParameters(operation: String, parameters: [Any])
    
    case badRequest
    
    case unauthorized
    
    case paymentRequired
    
    case forbidden
    
    case notFound
    
    case requestEntityTooLarge

    case unprocessableEntity
    
    case http(httpResponse: HTTPURLResponse, data: Data)
    
    case invalidResponse(Data)
    
    case deleteOperationFailed(String)
    
    case network(URLError)
    
    case unknown(Error?)
        
    static func ==(lhs: FetchError, rhs: FetchError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return (lhsError as NSError) == (rhsError as NSError)
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.missingRequiredFields(let lhsMessage), .missingRequiredFields(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.invalidParameters(let lhsOperation, let lhsParameters), .invalidParameters(let rhsOperation, let rhsParameters)):
            // Assuming [Any] can be compared using ==, which might not be true in all cases.
            // You may need a more complex comparison here depending on your specific use case.
            return lhsOperation == rhsOperation && lhsParameters as NSArray == rhsParameters as NSArray
        case (.badRequest, .badRequest),
            (.unauthorized, .unauthorized),
            (.paymentRequired, .paymentRequired),
            (.forbidden, .forbidden),
            (.notFound, .notFound),
            (.requestEntityTooLarge, .requestEntityTooLarge),
            (.unprocessableEntity, .unprocessableEntity):
            return true
        case (.http(let lhsResponse, let lhsData), .http(let rhsResponse, let rhsData)):
            return lhsResponse == rhsResponse && lhsData == rhsData
        case (.invalidResponse(let lhsData), .invalidResponse(let rhsData)):
            return lhsData == rhsData
        case (.deleteOperationFailed(let lhsMessage), .deleteOperationFailed(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.network(let lhsError), .network(let rhsError)):
            return lhsError == rhsError
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return (lhsError as NSError?) == (rhsError as NSError?)
        default:
            return false
        }
    }
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
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 402:
            throw NetworkError.paymentRequired
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 413:
            throw NetworkError.requestEntityTooLarge
        case 422:
            throw NetworkError.unprocessableEntity
        default:
            throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
    }
}


public enum NetworkError: Error, LocalizedError, Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
         switch (lhs, rhs) {
         case (.missingRequiredFields(let lhsMessage), .missingRequiredFields(let rhsMessage)):
             return lhsMessage == rhsMessage
         case (.invalidParameters(let lhsOperation, let lhsParameters), .invalidParameters(let rhsOperation, let rhsParameters)):
             // Assuming [Any] can be compared using ==, which might not be true in all cases.
             // You may need a more complex comparison here depending on your specific use case.
             return lhsOperation == rhsOperation && lhsParameters as NSArray == rhsParameters as NSArray
         case (.badRequest, .badRequest),
              (.unauthorized, .unauthorized),
              (.paymentRequired, .paymentRequired),
              (.forbidden, .forbidden),
              (.notFound, .notFound),
              (.requestEntityTooLarge, .requestEntityTooLarge),
              (.unprocessableEntity, .unprocessableEntity):
             return true
         case (.http(let lhsResponse, let lhsData), .http(let rhsResponse, let rhsData)):
             return lhsResponse == rhsResponse && lhsData == rhsData
         case (.invalidResponse(let lhsData), .invalidResponse(let rhsData)):
             return lhsData == rhsData
         case (.deleteOperationFailed(let lhsMessage), .deleteOperationFailed(let rhsMessage)):
             return lhsMessage == rhsMessage
         case (.network(let lhsError), .network(let rhsError)):
             return lhsError == rhsError
         case (.unknown(let lhsError), .unknown(let rhsError)):
             return (lhsError as NSError?) == (rhsError as NSError?)
         default:
             return false
         }
     }
     
    
    case missingRequiredFields(String)
    
    case invalidParameters(operation: String, parameters: [Any])
    
    case badRequest
    
    case unauthorized
    
    case paymentRequired
    
    case forbidden
    
    case notFound
    
    case requestEntityTooLarge

    case unprocessableEntity
    
    case http(httpResponse: HTTPURLResponse, data: Data)
    
    case invalidResponse(Data)
    
    case deleteOperationFailed(String)
    
    case network(URLError)
    
    case unknown(Error?)
}
