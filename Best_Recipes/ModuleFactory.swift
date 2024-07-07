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
        let presenter = RecipeDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func createHomeModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = HomeControllerImpl()
        let presenter = HomePresenterImpl(view: view)
        view.presenter = presenter
        presenter.flowHandler = flowHandler
        return view
    }
    
    func createBookMarkModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = BookmarkViewController()
        //        let presenter = BookmarkPresenter(view: view)
        //        view.presenter = presenter
        //        presenter.flowHandler = flowHandler
        return BookmarkViewController()
    }
    
    func createNotificationModule() -> UIViewController {
        return NotificationViewController()
    }
    
    func createProfileModule(flowHandler: (() -> Void)?) -> UIViewController {
        let view = ProfileViewController()
        //        let presenter = ProfilePresenter(view: view)
        //        view.presenter = presenter
        //        presenter.flowHandler = flowHandler
        return view
    }
    
}
