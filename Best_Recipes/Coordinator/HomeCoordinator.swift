//
//  HomeCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 06.07.2024.
//

import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    var rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        rootViewController.setViewControllers([getHomeScreen()], animated: false)
    }
    
    private func getHomeScreen() -> UIViewController {
        let vc = HomeAssembly().build(coordinator: self)
        vc.navigationItem.title = "Get amazing recipes for cooking"
        return vc
    }
    
    func goToDetail() {
        let recipeDetailVC = RecipeDetailsAssembly().build()
        rootViewController.pushViewController(recipeDetailVC, animated: true)
    }
}
