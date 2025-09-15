//
//  CoordinatorFactory.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

final class CoordinatorFactory {
    
    //MARK: - App Coordinator
   func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
       AppCoordinator(navigationController: navigationController)
   }
    
    //MARK: - MainFlowCoordinator
   func createMainFlowCoordinator(navigationController: UINavigationController) -> MainFlowCoordinator {
       MainFlowCoordinator(navigationController: navigationController)
   }
}
