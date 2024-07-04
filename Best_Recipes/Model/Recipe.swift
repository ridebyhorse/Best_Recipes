//
//  Recipe.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

struct SearchResults: Decodable {
    let searchResults: [SearchResult]
}

struct SearchResult: Decodable {
    let name: String
    let results: [Result]
}

struct Result: Decodable {
    var id: Int?
    let name: String
}

struct RecipeData: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable {
    var rating: Double
    let id: Int?
    let title: String
    let countries: [String]
    let categories: [String]
    let cookingTime: Int
    let isTrending: Bool
    let reviewsCount: Int
    let author: String
    let ingredients: [Ingridient]?
    let instructions: [Instruction]
    let image: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, image
        case countries = "cuisines"
        case categories = "dishTypes"
        case cookingTime = "readyInMinutes"
        case isTrending = "veryPopular"
        case reviewsCount = "aggregateLikes"
        case author = "sourceName"
        case ingredients = "extendedIngredients"
        case instructions = "analyzedInstructions"
        case rating = "spoonacularScore"
    }
}

struct Ingridient: Decodable {
    var image: String?
    let originalName: String
    let amount: Double
    let unit: String
}

struct InstructionStep: Decodable {
    let number: Int
    let step: String
}

struct Instruction: Decodable {
    let steps: [InstructionStep]
}
