//
//  HomeProtocol.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//

import UIKit

protocol HomePresenter: AnyObject  {
    var view: (any HomeController)? { get }
    init(view: any HomeController, coordinator: HomeCoordinator)
    func viewDidLoad()
    var coordinator: HomeCoordinator? { get }
}

protocol HomeController: Configurable {
    typealias Model = HomeViewModel
    var presenter: HomePresenter? { get }
}


