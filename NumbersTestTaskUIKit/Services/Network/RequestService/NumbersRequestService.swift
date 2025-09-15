//
//  NumbersRequestService.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

protocol CharactersListServiceAPIProtocol {
    func fetchNumberInfo(number: Int, completion: @escaping ResultCallback<NumberModel, AppError>)
    func fetchRandomNumberInfo(completion: @escaping ResultCallback<NumberModel, AppError>)
}

class NumberRequestService {
    
    // MARK: Private proporties
    private let httpService: HttpService
    
    // MARK: - Initialization
    init(httpService: HttpService = HttpService()) {
        self.httpService = httpService
    }
}

extension NumberRequestService: CharactersListServiceAPIProtocol {

    func fetchNumberInfo(number: Int, completion: @escaping ResultCallback<NumberModel, AppError>) {
        do {
            try NumbersRequestHttpRouter.fetchNumberInfo(number: number).request(usingHttpService: httpService) { result in
                switch result {
                case .success(let data):
                    guard let model: NumberModel = DecoderHelper.decode(data: data, model: NumberModel.self) else {
                        completion(.failure(.decoding))
                        return
                    }
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(.localizedError(localizedTitle: error.localizedDescription)))
        }
    }

    func fetchRandomNumberInfo(completion: @escaping ResultCallback<NumberModel, AppError>) {
        do {
            try NumbersRequestHttpRouter.fetchRandomNumberInfo.request(usingHttpService: httpService) { result in
                switch result {
                case .success(let data):
                    guard let model: NumberModel = DecoderHelper.decode(data: data, model: NumberModel.self) else {
                        completion(.failure(.decoding))
                        return
                    }
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(.localizedError(localizedTitle: error.localizedDescription)))
        }
    }
}
