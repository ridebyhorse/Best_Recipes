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
        //setupTabItems()
    }
    
//    private func setupTabItems() {
//        
//        let homeVC = MainScreenController()
//        homeVC.tabBarItem.image = UIImage(named: "Home")
//        
//        let favoritesVC = FavoritesController()
//        favoritesVC.tabBarItem.image = UIImage(named: "Bookmark")
//        
//        let imageEmpty = MainScreenController()
//        imageEmpty.tabBarItem.image = UIImage(named: "")
//        
//        let notificationVC = FavoritesController()
//        notificationVC.tabBarItem.image = UIImage(named: "Notification")
//        
//        let profileVC = FavoritesController()
//        profileVC.tabBarItem.image = UIImage(named: "Profile")
//        
//        setViewControllers([homeVC, favoritesVC, notificationVC, profileVC], animated: false)
//        
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = view.bounds.width / 5
        self.view.layoutIfNeeded()
    }
}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CustomTabBarController())
}
