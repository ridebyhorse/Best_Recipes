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
    private let storageManager = StorageService.shared
    
    @MainActor func activate() {
        loadData()
    }
    
    @MainActor private func loadData() {
        if let recipeId {
            StorageService.shared.addToRecentRecipes(recipeId: recipeId)
            self.recipe = networkManager.getRecipeById(recipeId) ?? findInFavs(id: recipeId) ?? findInRecent(id: recipeId) ?? MockData.getMockRecipes()?.first
        } else {
            self.recipe = MockData.getMockRecipes()?.first
        }
        updateUI()
    }
    
    @MainActor private func updateUI() {

        guard let recipe = recipe else { return }
        let imageURL = recipe.image
        let rating = String(format: "%.1f", recipe.rating / 20.0)
        let reviews = String(recipe.reviewsCount)
        
        let steps: [String] = recipe.instructions
            .first?
            .steps
            .compactMap { $0.step } ?? []
        
        let ingredients: [IngredientViewModel] = recipe.ingredients?
            .compactMap { ingredient in
                .init(
                    id: ingredient.id,
                    title: ingredient.originalName,
                    image: URL(string: "https://img.spoonacular.com/ingredients_100x100/" + (ingredient.image ?? "")),
                    amount: ingredient.amount,
                    unit: ingredient.unit,
                    isAvailable: storageManager.isIngredientSaved(ingredient.id),
                    availableHandler: { [weak self]  in
                        self?.storageManager.toggleAvailableIngredient(ingredient.id)
                         self?.updateUI()
                    }
                )
                
            } ?? []
        
        let isFavorite = storageManager.getFavoriteRecipes()
            .contains { $0.id == recipe.id }
        
        view?.update(with: .init(
            title: recipe.title,
            image: imageURL,
            rating: rating,
            reviewsCount: reviews,
            instructions: steps,
            ingredients: ingredients, 
            isFavorite: isFavorite,
            favoriteHandler: { [weak self] in
                if recipe.isFavorite {
                    print("\(recipe.id!) Recipe \(recipe.title) removed from favorites")
                } else {
                    print("\(recipe.id!) Recipe \(recipe.title) added to favorites")
                }
                self?.storageManager.toggleFavorite(recipeId: recipe.id)
                self?.updateUI()
            }
        ))
    }
    
    private func findInFavs(id: Int) -> Recipe? {
        let favs = storageManager.getFavoriteRecipes()
        if let index = favs.firstIndex(where: {$0.id == id}) {
            return favs[index]
        }
        return nil
    }
    
    private func findInRecent(id: Int) -> Recipe? {
        let recents = storageManager.getRecentRecipes()
        if let index = recents.firstIndex(where: {$0.id == id}) {
            return recents[index]
        }
        return nil
    }
}
