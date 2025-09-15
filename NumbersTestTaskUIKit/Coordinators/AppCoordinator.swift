//
//  AppCoordinator.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    enum CoordinatorType {
        case mainScreen
        case otherScreen
    }
    
    // MARK: - Public Properties
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorType: Coordinator] = [:]
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private Methods
    private func startMainScreen() {
        let mainFlowCoordinator = CoordinatorFactory().createMainFlowCoordinator(navigationController: navigationController)
        mainFlowCoordinator.start()
        
        childCoordinators.removeAll()
        childCoordinators[.mainScreen] = mainFlowCoordinator
    }
    
    // MARK: - Public Methods
    func start() {
        startMainScreen()
    }
}
