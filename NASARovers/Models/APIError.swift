//
//  APIError.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation

struct APIErrorResponse: Decodable {
    let error: APIError
}

struct APIError: Decodable {
    let code: String
    let message: String
}
