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
        case userKey = "user"
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
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: Key.userKey.rawValue)
        } catch {
            print("Error encoding user: \(error)")
        }
    }
    
    func toggleFavorite(recipeId id: Int) {
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
        if let data = userDefaults.data(forKey: Key.userKey.rawValue) {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                return user
            } catch {
                print("Error decoding user: \(error)")
            }
        }
        
        return User(name: "New User", location: "Moscow", recipesCreated: getCreatedRecipes().count)
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
        saveRecipes(forKey: key, recipes)
    }
    
    private func removeRecipe(forKey key: Key, recipeId id: Int) {
        var recipes = getRecipes(forKey: key)
        let index = recipes.firstIndex(where: {$0.id == id})
        if let index {
            recipes.remove(at: index)
        }
        saveRecipes(forKey: key, recipes)
    }
    
    private func getRecipes(forKey key: Key) -> [Recipe] {
        if let data = userDefaults.data(forKey: key.rawValue) {
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
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
            } catch {
                print("Error decoding recipes: \(error)")
            }
        }
        
        return []
    }
            
    private func saveRecipes(forKey key: Key, _ recipes: [Recipe]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(recipes)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            print("Error encoding recipes: \(error)")
        }
    }
    
}
