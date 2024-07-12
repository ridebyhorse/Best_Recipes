//
//  ModuleFactory.swift
//  Best_Recipes
//
//  Created by Natalia on 07.07.2024.
//

import UIKit

class ModuleFactory {
    
    func createRecipeDetailsModule() -> UIViewController {
        let view = RecipeDetailController()
        view.title = "Saved recipes"
        let presenter = RecipeDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func createHomeModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = HomeControllerImpl()
        view.title = "Get amazing recipes for cooking"
        let presenter = HomePresenterImpl(view: view)
        view.presenter = presenter
        presenter.flowHandler = flowHandler
        return view
    }
    
    func createBookMarkModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = BookmarkViewController()
        return view
    }
    
    func createRecipeCreationModule() -> UIViewController {
        return CreateRecipeViewController()
    }
    
    func createNotificationModule() -> UIViewController {
        let view = NotificationViewController()
        view.title = "Recent notifications"
        return view
    }
    
    func createProfileModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = ProfileViewController()
        view.title = "My profile"
        return view
    }
    
}
