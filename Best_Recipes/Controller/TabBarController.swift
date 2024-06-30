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
            generateVC(viewController: HomeViewController(), title: "Get amazing recipes for cooking", image: .home.withRenderingMode(.alwaysOriginal), selectedImage: .homeActive.withRenderingMode(.alwaysOriginal)),
            generateVC(viewController: BookmarkViewController(), title: "Saved recipes", image: .bookmark.withRenderingMode(.alwaysOriginal), selectedImage: .bookmarkActive.withRenderingMode(.alwaysOriginal)),
            generateVC(viewController: CreateRecipeViewController(), title: "Create recipe", image: .createRecipe.withRenderingMode(.alwaysOriginal), selectedImage: .createRecipe.withRenderingMode(.alwaysOriginal)),
            generateVC(viewController: NotificationViewController(), title: "Recent notifications", image: .notification.withRenderingMode(.alwaysOriginal), selectedImage: .notificationActive.withRenderingMode(.alwaysOriginal)),
            generateVC(viewController: ProfileViewController(), title: "My profile", image: .profile.withRenderingMode(.alwaysOriginal), selectedImage: .profileActive.withRenderingMode(.alwaysOriginal))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        viewController.navigationItem.title = title
        return UINavigationController(rootViewController: viewController)
    }
}
