//
//  CustomTapBarController.swift
//  Best_Recipes
//
//  Created by Сергей Сухарев on 02.07.2024.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(customTabBar, forKey: "tabBar")
        setupTabItems()
    }
    
    private func setupTabItems() {

        setViewControllers(generateTabBar(), animated: true)

    }
    private func generateTabBar() -> [UINavigationController] {
        [
            generateVC(viewController: HomeAssembly().build(), title: "Get amazing recipes for cooking", image: UIImage(imageLiteralResourceName: "Home"), selectedImage: UIImage(imageLiteralResourceName: "Home-active")),
            generateVC(viewController: RecipeDetailsAssembly().build(), title: "Saved recipes", image: UIImage(imageLiteralResourceName: "Bookmark"), selectedImage: UIImage(imageLiteralResourceName: "Bookmark-active")),
            UINavigationController(),
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
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CustomTabBarController())
}
