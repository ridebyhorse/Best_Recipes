//
//  ModuleFactory.swift
//  Best_Recipes
//
//  Created by Natalia on 07.07.2024.
//

import UIKit

class ModuleFactory {
    
    func createRecipeDetailsModule(id: Int) -> UIViewController {
        let view = RecipeDetailController()
        view.title = "Saved recipes"
        let presenter = RecipeDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.recipeId = id
        print(presenter.recipeId)
        return view
    }
    
    func createHomeModule(searchController: UISearchController, flowHandler: HomeNavigationHandler?) -> UIViewController {
        let view = HomeControllerImpl()
        view.title = "Get amazing recipes for cooking"
        let presenter = HomePresenterImpl(view: view)
        view.presenter = presenter
        view.searchController = searchController
        presenter.flowHandler = flowHandler
        return view
    }
    
    func createBookMarkModule(detailFlowHandler: ((Int) -> Void)?) -> UIViewController {
        let view = BookmarkControllerImpl()
        let presenter = BookmarkPresenterImpl(view: view)
        view.presenter = presenter
        presenter.detailFlowHandler = detailFlowHandler
        return view
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
    
    func createSearchModule(detailFlowHandler: ((Int) -> Void)?) -> UISearchController {
        let resultSearchController = SearchControllerImpl()
        let presenter = SearchPresenterImpl(view: resultSearchController)
        resultSearchController.presenter = presenter
        presenter.detailFlowHandler = detailFlowHandler
        let view = CustomSearchController(searchResultsController: resultSearchController)
        return view
    }
    
}
