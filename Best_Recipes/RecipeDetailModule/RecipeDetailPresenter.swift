//
//  RecipeDetailPresenter.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import Foundation

class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    
    weak var view: RecipeDetailController?
    
    var recipeId: Int?
    
    private var recipe: Recipe?
    
    private let networkManager = NetworkManager.shared
    
    func activate() {
        loadData()
    }
    
    private func loadData() {
        print(recipeId)
        if let recipeId {
            self.recipe = networkManager.getRecipeById(recipeId) ?? MockData.getMockRecipes()?.first
        } else {
            self.recipe = MockData.getMockRecipes()?.first
        }
        updateUI()
    }
    
    private func updateUI() {

        let imageURL = recipe!.image
        let rating = String(format: "%.1f", recipe!.rating / 20.0)
        let reviews = String(recipe!.reviewsCount)
        
        let steps: [String] = recipe?.instructions
            .first?
            .steps
            .compactMap { $0.step } ?? []
        
        let ingredients: [IngredientViewModel] = recipe?.ingredients?
            .compactMap {
                .init(
                    title: $0.originalName,
                    image: URL(string: "https://img.spoonacular.com/ingredients_100x100/" + ($0.image ?? "")),
                    amount: $0.amount,
                    unit: $0.unit
                )
            } ?? []
        
        view?.update(with: .init(
            title: recipe?.title ?? "",
            image: imageURL,
            rating: rating,
            reviewsCount: reviews,
            instructions: steps,
            ingredients: ingredients
        ))
    }
}
