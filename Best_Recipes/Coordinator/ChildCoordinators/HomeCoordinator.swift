//
//  HomeCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    var flowCompletionHandler: CoordinatorHandler?
    var rootViewController: UINavigationController
    
    private let moduleFactory: ModuleFactory
    
    init(_ moduleFactory: ModuleFactory) {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        self.moduleFactory = moduleFactory
    }
    
    func start() {
        rootViewController.setViewControllers([createHomeModule()], animated: false)
    }
    
    private func createHomeModule() -> UIViewController {
        moduleFactory.createHomeModule { [weak self] in
            self?.flowCompletionHandler?()
        }
    }
}
