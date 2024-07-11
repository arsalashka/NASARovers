//
//  APIDataProvider.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation
import Alamofire
import Combine

enum AppError: Error {
    case connectivityError
    case decodeJSONFailed
    case apiError(APIError)
    case networkError
    case other(_ error: String? = nil)
    
    case unknown
    
    var description: String {
        switch self {
        case .connectivityError: return "Connectivity Error"
        case .decodeJSONFailed: return "Decode JSON failed"
        case .apiError(let apiError): return apiError.message
        case .networkError: return "Network Error"
        case .other(let error): return error ?? "Unknown Error"
        case .unknown: return "Unknown Error"        }
    }
}

final class APIDataProvider {
    private let endpointProvider = APIEndpointProvider()

    func request<T: Decodable>(with endpoint: Endpoint) -> AnyPublisher<T, AppError> {
        print(endpointProvider.getURL(endpoint: endpoint))
        return URLSession.shared
            .dataTaskPublisher(for: endpointProvider.getURL(endpoint: endpoint))
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .mapError { _ in .connectivityError }
            .flatMap { data, response -> AnyPublisher<T, AppError> in
                let decoder = JSONDecoder()
                
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        
                        print(data)
                        
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError { _ in .decodeJSONFailed }
                            .eraseToAnyPublisher()
                    } else {
                        do {
                            let errorResponse = try decoder.decode(APIErrorResponse.self, from: data)
                            
                            return Fail(error: .apiError(errorResponse.error))
                                .eraseToAnyPublisher()
                        } catch {
                            return Fail(error: .decodeJSONFailed)
                                .eraseToAnyPublisher()
                        }
                    }
                }
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
