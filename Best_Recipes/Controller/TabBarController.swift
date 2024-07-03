//
//  TabBarController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeAssembly().build(), title: "Get amazing recipes for cooking", image: UIImage(imageLiteralResourceName: "Home"), selectedImage: UIImage(imageLiteralResourceName: "Home-active")),
            generateVC(viewController: BookmarkViewController(), title: "Saved recipes", image: UIImage(imageLiteralResourceName: "Bookmark"), selectedImage: UIImage(imageLiteralResourceName: "Bookmark-active")),
            generateVC(viewController: CreateRecipeViewController(), title: "Create recipe", image: UIImage(imageLiteralResourceName: "CreateRecipe"), selectedImage: UIImage(imageLiteralResourceName: "CreateRecipe")),
            generateVC(viewController: NotificationViewController(), title: "Recent notifications", image: UIImage(imageLiteralResourceName: "Notification"), selectedImage: UIImage(imageLiteralResourceName: "Notification-active")),
            generateVC(viewController: ProfileViewController(), title: "My profile", image: UIImage(imageLiteralResourceName: "Profile"), selectedImage: UIImage(imageLiteralResourceName: "Profile-active"))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        viewController.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        viewController.navigationItem.title = title
        return UINavigationController(rootViewController: viewController)
    }
}

