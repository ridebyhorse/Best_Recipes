//
//  RecipesCellViewModel.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//
import Foundation

struct RecipesCellViewModel: Hashable {
    let raiting: Double
    let recipeImage: URL
    let recipeName: String
    let isFavorite: Bool
    let avtorImage: URL
    let avtorName: String
}
