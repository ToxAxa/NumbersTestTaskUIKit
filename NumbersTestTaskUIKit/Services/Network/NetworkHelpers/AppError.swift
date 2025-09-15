//
//  AppError.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

typealias Callback<Model: Any> = ((Model) -> Void)
typealias ResultCallback<Model: Any, AppError: Error> = Callback<Result<Model, AppError>>

enum AppError: Error, LocalizedError {
    case invalidResponse
    case invalidData
    case decoding
    case invalidURL(urlString: String)
    case localizedError(localizedTitle: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "invalidResponse"
        case .invalidData:
            return "invalidData"
        case .localizedError(let localizedTitle):
            return localizedTitle
        case .decoding:
            return "invalidDataDecoding"
        case .invalidURL(let urlString):
            return urlString
        }
    }
}
