//
//  OnboardingCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

class OnboardingCoordinator: CoordinatorProtocol {

    var flowCompletionHandler: CoordinatorHandler?
    
    var rootViewController: UIViewController?

    func start() {
        showOnboarding()
    }
    
    private func showOnboarding() {
        let controller = OnBoardingViewController()
        rootViewController = controller
        controller.completionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }
    }
}
