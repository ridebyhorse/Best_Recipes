//
//  RecipeDetailCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 06.07.2024.
//

import UIKit

class RecipeDetailCoordinator: CoordinatorProtocol {
    
    var rootViewController: UINavigationController
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    func start() {
        rootViewController.setViewControllers([getRecipeDetailScreen()], animated: false)
    }
    
    func getRecipeDetailScreen() -> UIViewController {
        let vc = RecipeDetailsAssembly().build()
        vc.navigationItem.title = "Saved recipes"
        return vc
    }
    
}
