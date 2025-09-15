//
//  NumberModel.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

struct NumberModel: Codable {
    let numberDescription: String

    enum CodingKeys: String, CodingKey {
        case numberDescription = "text"
    }
}
