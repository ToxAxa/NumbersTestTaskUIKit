//
//  NumbersRequestHttpRouter.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

enum NumbersRequestHttpRouter {
    case fetchNumberInfo(number: Int)
    case fetchRandomNumberInfo
}

extension NumbersRequestHttpRouter: HttpRouter {

    var path: String {
        switch self {
        case .fetchNumberInfo(number: let number):
            return "\(number)"
        case .fetchRandomNumberInfo:
            return "random/math"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .fetchNumberInfo, .fetchRandomNumberInfo:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=UTF-8"]
    }
}
