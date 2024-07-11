//
//  HomeProtocol.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//

import UIKit

protocol HomePresenter: AnyObject  {
    var view: (any HomeController)? { get }
    init(view: any HomeController)
    func viewDidLoad()
    var flowHandler: HomeNavigationHandler? { get set }
}

protocol HomeController: Configurable {
    typealias Model = HomeViewModel
    var presenter: HomePresenter? { get }
}


typealias HomeNavigationHandler = (HomeNavigationModel) -> Void

enum HomeNavigationModel {
    case recipe(recipeId: Int)
    case seeAll(type: String)
}
