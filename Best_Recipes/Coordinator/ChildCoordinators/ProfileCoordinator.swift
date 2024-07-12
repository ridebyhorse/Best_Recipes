//
//  ProfileCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    
    var flowCompletionHandler: CoordinatorHandler?
    var rootViewController: UINavigationController
    
    private let moduleFactory: ModuleFactory
    
    init(_ moduleFactory: ModuleFactory) {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        self.moduleFactory = moduleFactory
    }
    
    func start() {
        rootViewController.setViewControllers([createProfileModule()], animated: false)
    }
    
    private func createProfileModule() -> UIViewController {
        moduleFactory.createProfileModule { [weak self] in
            self?.flowCompletionHandler?()
        }
    }
}
