//
//  RecipeDetailProtocols.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import Foundation

protocol RecipeDetailControllerProtocol: Configurable where Model == RecipeDetailViewModel { }

protocol RecipeDetailPresenterProtocol: AnyObject {
    func activate()
}
