//
//  SearchProtocol.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 06.07.2024.
//

import UIKit

protocol SearchPresenter: AnyObject  {
    var view: (any SearchController)? { get }
    init(view: any SearchController)
    func searchRecipeByKeyword(_ keyword: String)
    var detailFlowHandler: ((Int) -> Void)? { get set }
}

protocol SearchController: Configurable {
    typealias Model = SearchViewModel
    var presenter: SearchPresenter? { get }
}
