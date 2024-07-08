//
//  AppCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    
    var childCoordinators = [CoordinatorProtocol]()
    
    var hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    
    init(window: UIWindow) {
        self.window = window
        NetworkManager(networkService: NetworkService.shared).fetchRecipes()
    }
    
    func start() {
//        hasSeenOnboarding ? showMainFlow() : showOnboarding()
        showOnboarding()
    }
    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator()
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.rootViewController
    }
    
    func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator()
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
        window.rootViewController = onboardingCoordinator.rootViewController
        onboardingCoordinator.flowCompletionHandler = { [weak self] in
//            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            self?.showMainFlow()
        }
    }
}
