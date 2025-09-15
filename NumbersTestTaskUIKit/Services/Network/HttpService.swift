//
//  HttpService.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

protocol HttpServiceProtocol {
    func req(_ urlRequest: URLRequest, completionHandler: @escaping (Result<Data, AppError>) -> Void)
}

class HttpService: HttpServiceProtocol {

    func req(_ urlRequest: URLRequest, completionHandler: @escaping (Result<Data, AppError>) -> Void)  {

        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data, error == nil, 200...299 ~= statusCode  else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
        }
        session.resume()
    }
}
