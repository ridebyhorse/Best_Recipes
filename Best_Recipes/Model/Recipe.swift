//
//  Recipe.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String
    let cuisines: [String]
    let dishTypes: [String]
    let readyInMinutes: Int
    let veryPopular: Bool
    let aggregateLikes: Int
    let creditsText: String
    let extendedIngredients: [Ingridient]
    let analyzedInstructions: [Instruction]
    
    struct Ingridient: Codable {
        var imageLink: String {
            "https://img.spoonacular.com/ingredients_100x100/" + image
        }
        let image: String
        let originalName: String
        let amount: Double
        let unit: String
        
        private enum CodingKeys: String, CodingKey {
            case image, originalName, amount, unit
        }
    }
    
    struct Instruction: Codable {
        let step: [InstructionStep]
    }
    
    struct InstructionStep: Codable {
        let number: Int
        let step: String
    }
}
