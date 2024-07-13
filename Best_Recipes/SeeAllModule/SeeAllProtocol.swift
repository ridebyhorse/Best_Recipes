//
//  SeeAllProtocol.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import UIKit

protocol SeeAllPresenter: AnyObject  {
    var view: (any SeeAllController)? { get }
    init(view: any SeeAllController, mode: SeeAllMode)
    func viewDidLoad()
    var detailFlowHandler: ((Int) -> Void)? { get set }
    var mode: SeeAllMode { get set }
    var country: String? { get set }
}

protocol SeeAllController: Configurable {
    typealias Model = SeeAllViewModel
    var presenter: SeeAllPresenter? { get }
}
