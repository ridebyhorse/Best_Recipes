//
//  RecipeDetailController.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RecipeDetailController: UIViewController {
    
    private let customView = RecipeView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        guard let recipe = MockData.getMockRecipes()?.first else { return }
        configureView(with: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    private func getRecipes() {
        NetworkService.shared.fetchRecipes()
    }
    
    private func configureView(with recipe: Recipe) {
        var steps: [String] = []
        recipe.instructions.first?.steps.forEach {
            steps.append($0.step)
        }
        customView.configureView(
            title: recipe.title,
            steps: steps,
            ingredients: recipe.ingredients
        )
    }
}

