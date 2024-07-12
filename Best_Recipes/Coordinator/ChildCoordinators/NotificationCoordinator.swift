//
//  NotificationCoordinator.swift
//  Best_Recipes
//
//  Created by Natalia on 11.07.2024.
//

import UIKit

class NotificationCoordinator: CoordinatorProtocol {
    
    var flowCompletionHandler: CoordinatorHandler?
    var rootViewController: UINavigationController
    
    private let moduleFactory: ModuleFactory
    
    init(_ moduleFactory: ModuleFactory) {
        self.rootViewController = UINavigationController()
        self.moduleFactory = moduleFactory
    }
    
    func start() {
        rootViewController.setViewControllers([createNotificationModule()], animated: false)
    }
    
    private func createNotificationModule() -> UIViewController {
        moduleFactory.createNotificationModule()
    }
}
