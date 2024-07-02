//
//  RecipeDetailController.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RecipeDetailController: UIViewController {
    
    private let customView = RecipeView()
    
    init(recipe: Recipe = MockData.mockRecipeData) {
        super.init(nibName: nil, bundle: nil)
        
        configureView(with: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    private func configureView(with recipe: Recipe) {
        var steps: [String] = []
        recipe.analyzedInstructions.first?.step.forEach {
            steps.append($0.step)
        }
        customView.configureView(
            title: recipe.title,
            steps: steps,
            ingredients: recipe.extendedIngredients
        )
    }
}

@available(iOS 17.0, *) 
#Preview {
    RecipeDetailController(recipe: MockData.mockRecipeData)
}
