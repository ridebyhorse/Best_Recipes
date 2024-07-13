//
//  HomeProtocol.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//

import UIKit

protocol HomePresenter: AnyObject  {
    var view: (any HomeController)? { get }
    init(view: any HomeController, storageService: StorageService, networkManager: NetworkManager)
    var storageService: StorageService { get }
    var networkManager: NetworkManager { get }
    func viewDidLoad()
    var flowHandler: HomeNavigationHandler? { get set }
    func viewDidApear()
}

@MainActor
protocol HomeController: Configurable {
    typealias Model = HomeViewModel
    var presenter: HomePresenter? { get }
    var searchController: UISearchController? { get set }
}


typealias HomeNavigationHandler = (HomeNavigationModel) -> Void

enum HomeNavigationModel {
    case recipe(recipeId: Int)
    case seeAll(mode: SeeAllMode)
}


