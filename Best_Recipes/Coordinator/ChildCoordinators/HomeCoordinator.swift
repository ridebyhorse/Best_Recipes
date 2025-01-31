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
        rootViewController.navigationBar.tintColor = .black
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
            case .seeAll(mode: let mode):
                self?.showSeeAllModule(mode: mode)
            case .seeAllCertainCountry(country: let country):
                self?.showSeeAllModule(mode: .certainCountry, country: country)
                print(country)
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
    
    func showSeeAllModule(mode: SeeAllMode, country: String? = nil) {
        let vc = moduleFactory.createSeeAllModule(mode: mode, country: country) { [weak self] id in
            self?.showRecipeDetailsModule(id: id)
            print(country)
        }
        rootViewController.show(vc, sender: self)
    }
}
