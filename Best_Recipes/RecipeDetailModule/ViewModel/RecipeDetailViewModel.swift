//
//  RecipeDetailViewModel.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import Foundation

struct RecipeDetailViewModel {
    let title: String
    let image: URL?
    let rating: String
    let reviewsCount: String
    let instructions: [String]
    let ingredients: [IngredientViewModel]
    var isFavorite: Bool
    let favoriteHandler: (() -> Void)?
}

struct IngredientViewModel {
    let id: Int
    let title: String
    let image: URL?
    let amount: Double
    let unit: String
    var isAvailable: Bool
    let availableHandler: (() -> Void)?
    
    var amountAndUnit: String {
        "\(String(format: "%.0f", amount)) \(unit)"
    }
}
