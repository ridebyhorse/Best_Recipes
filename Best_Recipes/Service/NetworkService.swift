//
//  NetworkService.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let apiKey = "57a18417f2a547b29df04e67c6703ac8"
    private let baseUrlString = "https://api.spoonacular.com/recipes/random?number=100&apiKey="
    private var recipes = [Recipe]()

    private init() {}
    
    func getTrendingRecipes() -> [Recipe] {
        recipes.filter({ $0.isTrending})
    }
    
    func getCategories() -> [String] {
        var categories = [String]()
        recipes.forEach({
            categories += $0.categories
        })
        return Array(Set(categories))
    }
    
    func getRecipeForCategory(_ category: String) -> [Recipe] {
        recipes.filter({ $0.categories.contains(category) })
    }
    
    func getCountries() -> [String] {
        var countries = [String]()
        recipes.forEach({
            countries += $0.countries
        })
        return Array(Set(countries))
    }
    
    func getRecipeForCountry(_ country: String) -> [Recipe] {
        recipes.filter({ $0.countries.contains(country) })
    }

    private func fetchRecipes() async throws -> [Recipe] {
        let urlString = baseUrlString + apiKey
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let recipesResponse = try JSONDecoder().decode(RecipeData.self, from: data)
        return recipesResponse.recipes
    }
    
    func fetchRecipes() {
        Task {
            do {
                let result = try await fetchRecipes()
                recipes = result.filter({ $0.ingredients != nil })
            } catch {
                print("Ошибка при загрузке/поиске рецептов: \(error)")
            }
        }
    }
    
}
