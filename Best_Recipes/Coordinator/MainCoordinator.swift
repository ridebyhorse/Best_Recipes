//
//  MainCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

enum TabItem: String {
    case home
    case bookmark
    case recipeCreation
    case notification
    case profile
    
    var icon: UIImage? {
        switch self {
        case .home:
            getImage(named: "Home")
        case .bookmark:
            getImage(named: "Bookmark")
        case .notification:
            getImage(named: "Notification")
        case .profile:
            getImage(named: "Profile")
        default: nil
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:
            getImage(named: "Home-active")
        case .bookmark:
            getImage(named: "Bookmark-active")
        case .notification:
            getImage(named: "Notification-active")
        case .profile:
            getImage(named: "Profile-active")
        default: nil
        }
    }
    
    private func getImage(named name: String) -> UIImage {
        UIImage(imageLiteralResourceName: name).withRenderingMode(.alwaysOriginal)
    }
}

class MainCoordinator: CoordinatorProtocol {
    
    var rootViewController: UITabBarController
    var childCoordinators = [CoordinatorProtocol]()
    
    private let moduleFactory = ModuleFactory()
    
    init() {
        self.rootViewController = UITabBarController()
        let customTabBar = CustomTabBar()
        let vc = moduleFactory.createRecipeCreationModule()
        vc.modalPresentationStyle = .fullScreen
        customTabBar.onPlusButtonTap = {[weak self] in
            self?.rootViewController.present(vc, animated: true)}
        rootViewController.setValue(customTabBar, forKey: "tabBar")
    }
    
    func start() {
        let homeNavigationVC = getHomeCoordinator().rootViewController
        homeNavigationVC.tabBarItem = getTab(for: .home)
        
        let bookmarkNavigationVC = getBookmarkCoordinator().rootViewController
        bookmarkNavigationVC.tabBarItem = getTab(for: .bookmark)
        
        let recipeCreationNavVC = getRecipeCreationCoordinator().rootViewController
        
        let notificationNavigationVC = getNotificationCoordinator().rootViewController
        notificationNavigationVC.tabBarItem = getTab(for: .notification)
        
        let profileNavigationVC = getProfileCoordinator().rootViewController
        profileNavigationVC.tabBarItem = getTab(for: .profile)
        
        rootViewController.setViewControllers([homeNavigationVC, bookmarkNavigationVC, recipeCreationNavVC, notificationNavigationVC, profileNavigationVC], animated: false)
    }
    
    private func getHomeCoordinator() -> HomeCoordinator {
        let coordinator = HomeCoordinator(moduleFactory)
        coordinator.start()
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    private func getBookmarkCoordinator() -> BookmarkCoordinator {
        let coordinator = BookmarkCoordinator(moduleFactory)
        coordinator.start()
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    private func getRecipeCreationCoordinator() -> RecipeCreationCoordinator {
        let coordinator = RecipeCreationCoordinator(moduleFactory)
        coordinator.start()
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    private func getNotificationCoordinator() -> NotificationCoordinator {
        let coordinator = NotificationCoordinator(moduleFactory)
        coordinator.start()
        childCoordinators.append(coordinator)
        return coordinator
    }
    
    private func getProfileCoordinator() -> ProfileCoordinator {
        let coordinator = ProfileCoordinator(moduleFactory)
        coordinator.start()
        childCoordinators.append(coordinator)
        return coordinator
    }

    private func getTab(for item: TabItem) -> UITabBarItem {
        UITabBarItem(
            title: nil,
            image: item.icon,
            selectedImage: item.selectedIcon
        )
    }
}
