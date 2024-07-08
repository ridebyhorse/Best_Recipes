//
//  SearchAssembly.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 06.07.2024.
//

import UIKit

class SearchAssembly {
    func build() -> UIViewController {
        let view = SearchControllerImpl()
        let presenter  = SearchPresenterImpl(view: view)
        view.presenter = presenter
        return view
    }
    
}
