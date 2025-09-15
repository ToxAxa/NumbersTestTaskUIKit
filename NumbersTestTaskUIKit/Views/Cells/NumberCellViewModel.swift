//
//  NumberCellViewModel.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation

protocol NumberCellViewModelProtocol {
    var titleNumber: String {get}
    var descriptionNumber: String {get}
    init(model: NumberInfoData)
}

class NumberCellViewModel: NumberCellViewModelProtocol {

    // MARK: - Private Variables
    private let model: NumberInfoData
    
    var titleNumber: String {
        "Number \(model.title ?? "") was tapped" 
    }
    
    var descriptionNumber: String {
        model.descriptionNumber ?? ""
    }
    
    // MARK: - Lifecycle
    required init(model: NumberInfoData) {
        self.model = model
    }
}
