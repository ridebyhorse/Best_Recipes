//
//  HomeCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
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
        moduleFactory.createHomeModule(searchController: createSearchModule()) { [weak self] model in
            switch model {
            case .recipe(recipeId: let recipeId):
                self?.showRecipeDetailsModule(id: recipeId)
            case .seeAll(type: let type):
                break
            }
        }
    }
    
    func createSearchModule() -> UISearchController {
        moduleFactory.createSearchModule { [weak self] id in
            self?.showRecipeDetailsModule(id: id)
        }
    }
    
    func showRecipeDetailsModule(id: Int) {
        let vc = moduleFactory.createRecipeDetailsModule(id: id)
        rootViewController.show(vc, sender: self)
    }
}
