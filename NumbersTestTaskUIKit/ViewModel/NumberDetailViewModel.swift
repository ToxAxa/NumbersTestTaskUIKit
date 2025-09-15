//
//  NumberDetailViewModel.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

protocol NumberDetailViewModelProtocol {
    init(model: NumberInfoData)
}

final class NumberDetailViewModel: NumberDetailViewModelProtocol {
    
    let model: NumberInfoData
    
    init(model: NumberInfoData) {
        self.model = model
    }
}
