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
        view.title = "Recipe detail"
        let presenter = RecipeDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.recipeId = id
        return view
    }
    
    func createSeeAllModule(mode: SeeAllMode, detailFlowHandler: ((Int) -> Void)?) -> UIViewController {
        let view = SeeAllControllerImpl()
        view.title = mode.rawValue
        let presenter = SeeAllPresenterImpl(view: view, mode: mode)
        presenter.detailFlowHandler = detailFlowHandler
        view.presenter = presenter
        return view
    }
    
    func createHomeModule(searchController: UISearchController, flowHandler: HomeNavigationHandler?) -> UIViewController {
        let view = HomeControllerImpl()
        view.title = "Get amazing recipes for cooking"
        let network = NetworkManager.shared
        let storage = StorageService.shared
        let presenter = HomePresenterImpl(view: view, storageService: storage, networkManager: network)
        view.presenter = presenter
        view.searchController = searchController
        presenter.flowHandler = flowHandler
        return view
    }
    
    func createBookMarkModule(detailFlowHandler: ((Int) -> Void)?) -> UIViewController {
        let view = BookmarkControllerImpl()
        view.title = "Saved recipes"
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
    
    func createRecipeCreationModule() -> UIViewController {
        CreateRecipeViewController()
    }
}
