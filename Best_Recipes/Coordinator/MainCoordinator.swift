//
//  MainCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {

    private let customTabBar = CustomTabBar()
    
    var rootViewController: UITabBarController
    
    var childCoordinators = [CoordinatorProtocol]()
    
    init() {
        self.rootViewController = UITabBarController()
        rootViewController.setValue(customTabBar, forKey: "tabBar")
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        let homeVC = homeCoordinator.rootViewController
        setup(vc: homeVC, imageName: "Home", selectedImageName: "Home-active")
        
        let recipeDetailCoordinator = RecipeDetailCoordinator()
        recipeDetailCoordinator.start()
        childCoordinators.append(recipeDetailCoordinator)
        let recipeDetailVC = recipeDetailCoordinator.rootViewController
        setup(vc: recipeDetailVC, imageName: "Bookmark", selectedImageName: "Bookmark-active")
        
        
        let notificationVC = UINavigationController(rootViewController: NotificationViewController())
        notificationVC.title = "Recent notifications"
        setup(vc: notificationVC, imageName: "Notification", selectedImageName: "Notification-active")
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.title = "My profile"
        setup(vc: profileVC, imageName: "Profile", selectedImageName: "Profile-active")
        
        rootViewController.setViewControllers([homeVC, recipeDetailVC, UINavigationController(), notificationVC, profileVC], animated: true)
    }
    
    private func getRecipeDetailsScreen() -> UIViewController {
        RecipeDetailsAssembly().build()
    }

    
    func setup(vc: UIViewController, imageName: String, selectedImageName: String) {
        vc.tabBarItem.image = UIImage(imageLiteralResourceName: imageName).withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(imageLiteralResourceName: selectedImageName).withRenderingMode(.alwaysOriginal)
    }
}
