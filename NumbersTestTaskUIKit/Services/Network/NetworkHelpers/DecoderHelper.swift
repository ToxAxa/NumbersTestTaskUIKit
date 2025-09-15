//
//  DecoderHelper.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

final class DecoderHelper {
    static func decode<S: Codable>(data: Data?, model: S.Type) -> S? {
        guard let data = data else {return nil}
        do {
            let propertiesModel = try JSONDecoder().decode(S.self, from: data)
            return propertiesModel
        } catch {
            return nil
        }
    }
}
