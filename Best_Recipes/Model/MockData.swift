//
//  MockData.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import Foundation

struct MockData {
    static let mockRecipeData = Recipe(
        id: 1,
        title: "Tasty Fish (point & Kill)",
        cuisines: ["African", "Seafood"],
        dishTypes: ["Main Course", "Dinner"],
        readyInMinutes: 45,
        veryPopular: true,
        aggregateLikes: 350,
        creditsText: "Chef John Doe",
        extendedIngredients: [
            Recipe.Ingridient(
                image: "salmon.png",
                originalName: "Salmon",
                amount: 2,
                unit: "fillets"
            ),
            Recipe.Ingridient(
                image: "olive-oil.jpg",
                originalName: "Olive Oil",
                amount: 2,
                unit: "tablespoons"
            ),
            Recipe.Ingridient(
                image: "garlic.png",
                originalName: "Garlic",
                amount: 3,
                unit: "cloves"
            ),
            Recipe.Ingridient(
                image: "lemon.png",
                originalName: "Lemon",
                amount: 1,
                unit: ""
            )
        ],
        analyzedInstructions: [
            Recipe.Instruction(
                step: [
                    Recipe.InstructionStep(
                        number: 1,
                        step: "Preheat your oven to 400°F (200°C)."
                    ),
                    Recipe.InstructionStep(
                        number: 2,
                        step: "Place the salmon fillets on a baking sheet."
                    ),
                    Recipe.InstructionStep(
                        number: 3,
                        step: "Drizzle olive oil over the salmon fillets."
                    ),
                    Recipe.InstructionStep(
                        number: 4,
                        step: "Sprinkle minced garlic and lemon juice over the fillets."
                    ),
                    Recipe.InstructionStep(
                        number: 5,
                        step: "Bake in the preheated oven for 20 minutes, or until the salmon is cooked through."
                    ),
                    Recipe.InstructionStep(
                        number: 6,
                        step: "Serve hot with a side of your choice."
                    )
                ]
            )
        ]
    )

//    func printMockRecipeData() {
//        print("Recipe ID: \(mockRecipeData.id)")
//        print("Title: \(mockRecipeData.title)")
//        print("Cuisines: \(mockRecipeData.cuisines.joined(separator: ", "))")
//        print("Dish Types: \(mockRecipeData.dishTypes.joined(separator: ", "))")
//        print("Ready in Minutes: \(mockRecipeData.readyInMinutes)")
//        print("Very Popular: \(mockRecipeData.veryPopular)")
//        print("Aggregate Likes: \(mockRecipeData.aggregateLikes)")
//        print("Credits: \(mockRecipeData.creditsText)")
//        
//        print("\nIngredients:")
//        for ingredient in mockRecipeData.extendedIngredients {
//            print("- \(ingredient.originalName): \(ingredient.amount) \(ingredient.unit) (\(ingredient.imageLink))")
//        }
//        
//        print("\nInstructions:")
//        for instruction in mockRecipeData.analyzedInstructions {
//            for step in instruction.step {
//                print("Step \(step.number): \(step.step)")
//            }
//        }
//    }
}
