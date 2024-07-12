//
//  MainCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    var rootViewController: UITabBarController
    var flowCompletionHandler: CoordinatorHandler?
    
    private let moduleFactory = ModuleFactory()
    
    init() {
        self.rootViewController = UITabBarController()
        let customTabBar = CustomTabBar()
        let createRecipeVC = CreateRecipeViewController()
        createRecipeVC.modalPresentationStyle = .fullScreen
        customTabBar.onPlusButtonTap = {[weak self] in
            self?.rootViewController.present(createRecipeVC, animated: true)}
        rootViewController.setValue(customTabBar, forKey: "tabBar")
    }
    
    func start() {
        let controllers = getControllers()
        rootViewController.setViewControllers(controllers, animated: true)
    }
    
    func showBookmarkModule() {
        let vc = createBookmarkModule()
        rootViewController.show(vc, sender: self)
    }
    
//    func showHomeModule() {
//        let vc = createRecipeDetailsModule()
//        rootViewController.show(vc, sender: self)
//    }
    
    func showRecipeDetailsModule(id: Int) {
        let vc = createRecipeDetailsModule(id: id)
        rootViewController.show(vc, sender: self)
    }
    
    func createRecipeDetailsModule(id: Int) -> UIViewController {
        moduleFactory.createRecipeDetailsModule(id: id)
    }
    
    func createHomeModule() -> UIViewController {
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
    
    func createBookmarkModule() -> UIViewController {
        moduleFactory.createBookMarkModule { [weak self] id in
            self?.showRecipeDetailsModule(id: id)
        }
    }
    
    func createNotificationModule() -> UIViewController {
        moduleFactory.createNotificationModule()
    }
    
    func createProfileModule() -> UIViewController {
        moduleFactory.createProfileModule { [weak self] in
            self?.showBookmarkModule()
        }
    }
    
    private func getControllers() -> [UINavigationController] {
        [
            setup(vc: createHomeModule(), title: "Get amazing recipes for cooking", imageName: "Home", selectedImageName: "Home-active"),
            setup(vc: createBookmarkModule(), title: "Saved recipes", imageName: "Bookmark", selectedImageName: "Bookmark-active"),
            UINavigationController(),
            setup(vc: createNotificationModule(), title: "Recent notifications", imageName: "Notification", selectedImageName: "Notification-active"),
            setup(vc: ProfileViewController(), title: "My profile", imageName: "Profile", selectedImageName: "Profile-active")
        ]
    }
    
    private func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        vc.tabBarItem.image = UIImage(imageLiteralResourceName: imageName).withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(imageLiteralResourceName: selectedImageName).withRenderingMode(.alwaysOriginal)
        vc.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
