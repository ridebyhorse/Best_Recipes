//
//  RecipesCellViewModel.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//
import Foundation

struct RecipesCellViewModel: Hashable {
    let id: Int
    let raiting: Double
    let recipeImage: URL
    let recipeName: String
    let isFavorite: Bool
    let avtorImage: String
    let avtorName: String
    let didSelect: (() -> Void)?
    let favoriteHandler: (() -> Void)?
    
    static func == (lhs: RecipesCellViewModel, rhs: RecipesCellViewModel) -> Bool {
        lhs.hashValue == lhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(isFavorite)
        hasher.combine(id)
    }
}
