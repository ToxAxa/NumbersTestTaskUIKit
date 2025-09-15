//
//  MainFlowCoordinator.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

protocol MainFlowCoordinatorProtocol {
    func showNumberDetailScreen(model: NumberInfoData)
}

final class MainFlowCoordinator: Coordinator {
    
    // MARK: - Public Properties
    var navigationController: UINavigationController
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    func start() {
        let view = MainViewController()
        let numberRequestService = NumberRequestService()
        let coreDataService = CoreDataService()
        let viewModel = MainViewModel(requestService: numberRequestService, coreDataService: coreDataService)
        
        view.viewModel = viewModel
        
        viewModel.showNumberDetailScreenAction = { [weak self] infoModel in
            guard let self = self else { return }
            self.showNumberDetailScreen(model: infoModel)
        }

        pushViewController(view: view)
    }
}

// MARK: - MainFlowCoordinatorProtocol
extension MainFlowCoordinator: MainFlowCoordinatorProtocol {
    func showNumberDetailScreen(model: NumberInfoData) {
        let view = NumberDetailViewController()
        let viewModel = NumberDetailViewModel(model: model)
        
        view.viewModel = viewModel

        pushViewController(view: view)
    }
}
