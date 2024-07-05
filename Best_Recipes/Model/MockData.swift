//
//  MockData.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import Foundation

struct MockData {
    static func getMockRecipes() -> [Recipe]? {
        guard
            let url = Bundle.main.url(forResource: "mockData", withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else { return nil }
        
        do {
            let recipesData = try JSONDecoder().decode(RecipeData.self, from: data)
            return recipesData.recipes
        } catch {
            print("Ошибка декодирования JSON: \(error)")
            return nil
        }
    }
    
    static func getMockRecipesMore() -> [Recipe]? {
        guard
            let url = Bundle.main.url(forResource: "MockRecipe", withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else { return nil }
        
        do {
            print(data)
            let recipesData = try JSONDecoder().decode(RecipeData.self, from: data)
            return recipesData.recipes
        } catch {
            print("Ошибка декодирования JSON: \(error)")
            return nil
        }
    }
}



