//
//  BookmarkCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class BookmarkCoordinator: CoordinatorProtocol {
    
    var flowCompletionHandler: CoordinatorHandler?
    var rootViewController: UINavigationController
    
    private let moduleFactory: ModuleFactory
    
    init(_ moduleFactory: ModuleFactory) {
        self.rootViewController = UINavigationController()
        self.moduleFactory = moduleFactory
    }
    
    func start() {
        rootViewController.setViewControllers([createBookmarkModule()], animated: false)
    }
    
    private func createBookmarkModule() -> UIViewController {
        moduleFactory.createBookMarkModule { [weak self] id in
            self?.showRecipeDetailsModule(id: id)
        }
    }
    
    func showRecipeDetailsModule(id: Int) {
        let vc = moduleFactory.createRecipeDetailsModule(id: id)
        rootViewController.show(vc, sender: self)
    }
}
