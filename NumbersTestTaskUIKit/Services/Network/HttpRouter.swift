//
//  HttpRouter.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol HttpRouter {
    var baseURLString: String { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
}

extension HttpRouter {
    
    var baseURLString: String { "http://numbersapi.com/" }
    
    func asURLRequest() throws -> URLRequest {
        
        let urlComponents = NSURLComponents(string: baseURLString + path)
        
        guard let url = urlComponents?.url else {
            throw AppError.localizedError(localizedTitle: "Opps")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        return request
    }
    
    func request(usingHttpService service: HttpServiceProtocol,
                 completionHandler: @escaping (Result<Data, AppError>) -> Void) throws {
        try service.req(asURLRequest(), completionHandler: completionHandler)
    }
}

