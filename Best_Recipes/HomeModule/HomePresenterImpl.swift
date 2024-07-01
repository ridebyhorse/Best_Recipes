//
//  HomePresenterImpl.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

final class HomePresenterImpl: HomePresenter {
    weak var view: (any HomeController)?
    var flowHandler: (() -> Void)?
    
    init(view: any HomeController) {
        self.view = view
    }
    
    private func viewDidLoad() {
        view?.update(
            with: .init(
                tandingNow: .init(
                    resepies: [],
                    headerName: "Tranding now",
                    
                    seeAllHandler: {
                        self.flowHandler?()
                    }
                )
            )
        )
    }
}
