//
//  StorageService.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

class StorageService {
    
    let networkManager = NetworkManager.shared
    
    static let shared = StorageService()
    
    private let userDefaults = UserDefaults.standard
    private enum Key: String {
        case createdRecipesKey = "createdRecipes"
        case favoriteRecipiesKey = "favoriteRecipes"
        case recentRecipiesKey = "recentRecipes"
        case user = "user"
        case availableIngredientsId
    }

    private init() {}
    
    func getCreatedRecipes() -> [Recipe] {
        getRecipes(forKey: .createdRecipesKey)
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        getRecipes(forKey: .favoriteRecipiesKey)
    }
    
    func getRecentRecipes() -> [Recipe] {
        getRecipes(forKey: .recentRecipiesKey)
    }
    
    func saveCreatedRecipe(_ recipe: Recipe) {
        addRecipe(forKey: .createdRecipesKey, recipe)
    }
    
    func addToRecentRecipes(recipeId id: Int) {
        let recipe = networkManager.getRecipeById(id)
        guard let recipe else { return }
        addRecipe(forKey: .recentRecipiesKey, recipe)
    }
    
    func saveUserData(user: User) {
        set(user, forKey: .user)
    }
    
    func toggleFavorite(recipeId id: Int?) {
        guard let id = id else {
            print("Recipe id does not exist")
            return
        }
        let recipes = getRecipes(forKey: .favoriteRecipiesKey)
        if recipes.contains(where: {$0.id == id}) {
            networkManager.updateFav(id: id)
            removeRecipe(forKey: .favoriteRecipiesKey, recipeId: id)
        } else {
            let recipe = networkManager.getRecipeById(id)
            networkManager.updateFav(id: id)
            guard var recipe else { return }
            addRecipe(forKey: .favoriteRecipiesKey, recipe)
        }
    }
    
    func getUser() -> User {
        let user: User = get(.user) ?? User(
            name: "New User",
            location: "Moscow",
            recipesCreated: getCreatedRecipes().count
        )
        return user
    }
    
    func isIngredientSaved(_ id: Int) -> Bool {
        getIngredientsId().contains(where: { $0 == id })
    }
    
    func toggleAvailableIngredient(_ id: Int) {
        isIngredientSaved(id)
        ? removeIngredient(id: id)
        : saveIngredient(id)
    }
    
    private func getIngredientsId() -> [Int] {
        let ingredientsId: [Int] = get(.availableIngredientsId) ?? []
        return ingredientsId
    }
    
    private func saveIngredient(_ id: Int) {
        var ids = getIngredientsId()
        ids.append(id)
        set(ids, forKey: .availableIngredientsId)
    }
    
    private func removeIngredient(id: Int) {
        var ids = getIngredientsId()
        guard let index = ids.firstIndex(where: { $0 == id }) else { return }
        ids.remove(at: index)
        set(ids, forKey: .availableIngredientsId)
    }
    
    private func addRecipe(forKey key: Key, _ recipe: Recipe) {
        var recipes = getRecipes(forKey: key)
        if !recipes.contains(where: {$0.id == recipe.id}) {
            if key == .recentRecipiesKey {
                recipes.insert(recipe, at: 0)
            } else {
                recipes.append(recipe)
            }
        }
        set(recipes, forKey: key)
    }
    
    private func removeRecipe(forKey key: Key, recipeId id: Int) {
        var recipes = getRecipes(forKey: key)
        let index = recipes.firstIndex(where: {$0.id == id})
        if let index {
            recipes.remove(at: index)
        }
        set(recipes, forKey: key)
    }
    
    private func getRecipes(forKey key: Key) -> [Recipe] {
        let recipes: [Recipe]? = get(key)
        guard let recipes = recipes else { return [] }
        
        if key == .favoriteRecipiesKey {
            var favRecipes = recipes
            for (index, var recipe) in recipes.enumerated() {
                recipe.isFavorite = true
                favRecipes.remove(at: index)
                favRecipes.insert(recipe, at: index)
            }
            return favRecipes
        }
        return recipes
    }
            
    private func set<T: Encodable>(_ value: T, forKey key: Key) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            print("Error encoding \(key.rawValue): \(error)")
        }
    }
    
    private func get<T: Decodable>(_ key: Key) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue) {
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                return value
            } catch {
                print("Error decoding \(key.rawValue): \(error)")
                return nil
            }
        }
        return nil
    }
}
