//
//  Recipe.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

struct RecipeData: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable {
    var rating: String {
        String(format: "%.1f", spoonacularScore / 20.0)
    }
    private let id: Int
    let title: String
    let countries: [String]
    let categories: [String]
    let cookingTime: Int
    let isTrending: Bool
    let reviewsCount: Int
    let author: String
    private let spoonacularScore: Double
    let ingredients: [Ingridient]?
    let instructions: [Instruction]
    
    struct Ingridient: Decodable {
        var imageLink: String {
            "https://img.spoonacular.com/ingredients_100x100/" + (image ?? "")
        }
        let image: String?
        let originalName: String
        let amount: Double
        let unit: String
        
        private enum CodingKeys: String, CodingKey {
            case image, originalName, amount, unit
        }
    }
    
    struct Instruction: Decodable {
        let steps: [InstructionStep]
    }
    
    struct InstructionStep: Decodable {
        let number: Int
        let step: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, spoonacularScore
        case countries = "cuisines"
        case categories = "dishTypes"
        case cookingTime = "readyInMinutes"
        case isTrending = "veryPopular"
        case reviewsCount = "aggregateLikes"
        case author = "sourceName"
        case ingredients = "extendedIngredients"
        case instructions = "analyzedInstructions"
    }
}
