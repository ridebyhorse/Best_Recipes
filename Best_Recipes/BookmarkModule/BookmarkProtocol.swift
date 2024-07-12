//
//  BookmarkProtocol.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 11.07.2024.
//

import Foundation

protocol BookmarkPresenter: AnyObject  {
    var view: (any BookmarkController)? { get }
    init(view: any BookmarkController)
    func viewDidLoad()
    var detailFlowHandler: ((Int) -> Void)? { get set }
}

protocol BookmarkController: Configurable {
    typealias Model = BookmarkViewModel
    var presenter: BookmarkPresenter? { get }
}
