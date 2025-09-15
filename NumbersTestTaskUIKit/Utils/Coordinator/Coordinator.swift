//
//  Coordinator.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func pushViewController(view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
}
