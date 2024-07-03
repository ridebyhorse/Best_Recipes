//
//  RecipesCellViewModel.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//
import Foundation

struct RecipesCellViewModel: Hashable, Identifiable {
    let id = UUID()
    let recipeid: Int
    let raiting: Double
    let recipeImage: URL
    let recipeName: String
    var isFavorite: Bool
    let avtorImage: String
    let avtorName: String
    let coockingTime: Int
    let didSelect: (() -> Void)?
    let favoriteHandler: (() -> Void)?
    
    static func == (lhs: RecipesCellViewModel, rhs: RecipesCellViewModel) -> Bool {
           return lhs.id == rhs.id &&  lhs.isFavorite == rhs.isFavorite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(isFavorite)
        hasher.combine(id)
    }
}
//
//struct RecipesCategoryCellViewModel: Hashable, Identifiable {
//    let id = UUID()
//    let recipeid: Int
//    let raiting: Double
//    let recipeImage: URL
//    let recipeName: String
//    var isFavorite: Bool
//    
//    let didSelect: (() -> Void)?
//    let favoriteHandler: (() -> Void)?
//    
//    static func == (lhs: RecipesCategoryCellViewModel, rhs: RecipesCategoryCellViewModel) -> Bool {
//           return lhs.id == rhs.id &&  lhs.isFavorite == rhs.isFavorite
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(isFavorite)
//        hasher.combine(id)
//    }
//}
//
//struct RecipesCategoryCellViewModel: Hashable, Identifiable {
//    let id = UUID()
//    let recipeid: Int
//    let raiting: Double
//    let recipeImage: URL
//    let recipeName: String
//    var isFavorite: Bool
//    let coockingTime: Int
//    let didSelect: (() -> Void)?
//    let favoriteHandler: (() -> Void)?
//    
//    static func == (lhs: RecipesCategoryCellViewModel, rhs: RecipesCategoryCellViewModel) -> Bool {
//           return lhs.id == rhs.id &&  lhs.isFavorite == rhs.isFavorite
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(isFavorite)
//        hasher.combine(id)
//    }
//}
