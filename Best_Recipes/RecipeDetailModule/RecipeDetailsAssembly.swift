//
//  RecipeDetailsAssembly.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import UIKit

final class RecipeDetailsAssembly {
    
    func build() -> UIViewController {
        let presenter = RecipeDetailPresenter()
        let controller = RecipeDetailController()
        controller.presenter = presenter
        presenter.view = controller
        return controller
    }
}
