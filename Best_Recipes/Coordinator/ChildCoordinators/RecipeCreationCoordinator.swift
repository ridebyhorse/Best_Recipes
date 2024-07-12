//
//  RecipeCreationCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class RecipeCreationCoordinator: CoordinatorProtocol {
    
    var flowCompletionHandler: CoordinatorHandler?
    var rootViewController: UINavigationController
    
    private let moduleFactory: ModuleFactory
    
    init(_ moduleFactory: ModuleFactory) {
        self.rootViewController = UINavigationController()
        self.moduleFactory = moduleFactory
    }
    
    func start() {
        rootViewController.setViewControllers([createRecipeCreationModule()], animated: false)
    }
    
    private func createRecipeCreationModule() -> UIViewController {
        moduleFactory.createRecipeCreationModule()
    }
}
