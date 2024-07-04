//
//  RecipeDetailPresenter.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import Foundation

class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    
    weak var view: RecipeDetailController?
    
    private var recipe: Recipe?
    
    func activate() {
        loadData()
    }
    
    private func loadData() {
        if let recipe = MockData.getMockRecipes()?.first {
            self.recipe = recipe
            updateUI()
        } else {
            //showError
        }
    }
    
    private func updateUI() {
        
#warning("to do")
        let imageURL = URL(string: "")
        let rating = "4,5"
        let reviews = "300"
        
        let steps: [String] = recipe?.instructions
            .first?
            .steps
            .compactMap { $0.step } ?? []
        
        let ingredients: [IngredientViewModel] = recipe?.ingredients?
            .compactMap {
                .init(
                    title: $0.originalName,
                    image: URL(string: $0.image ?? ""),
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
