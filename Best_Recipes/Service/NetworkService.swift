//
//  NetworkService.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private let apiKeys = ["aed8a716eb104d529457e9bdfa716c0b", "57a18417f2a547b29df04e67c6703ac8"]
    private var currentApiKey = 0
    private let baseUrlString = "https://api.spoonacular.com/recipes/random?number=100&apiKey="
    private let countryUrlStringStart = "https://api.spoonacular.com/recipes/complexSearch?cuisine="
    private let countryUrlStringEnd = "&number=20&apiKey="
    private let searchByKeywordUrlStringStart = "https://api.spoonacular.com/food/search?query="
    private let searchByKeywordUrlStringEnd = "&number=10&apiKey="
    private let searchByIdUrlString = "https://api.spoonacular.com/recipes/informationBulk?ids="

    private init() {
        Task {
            try await KeyConstant.loadAPIKeys()
        }
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = baseUrlString + apiKeys[currentApiKey]
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipesResponse = try JSONDecoder().decode(RecipeData.self, from: data)
        
        return recipesResponse.recipes
    }
    
    func searchRecipesForCountry(country: String) async throws -> [CountryResult] {
        let urlString = countryUrlStringStart + country + countryUrlStringEnd + apiKeys[currentApiKey]
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipesResponse = try JSONDecoder().decode(CountrySearchResult.self, from: data)
        
        return recipesResponse.results
    }
    
    func searchRecipes(byKeyword keyword: String) async throws -> [SearchResult] {
        let urlString = searchByKeywordUrlStringStart + keyword + searchByKeywordUrlStringEnd + apiKeys[currentApiKey]
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let searchResponse = try JSONDecoder().decode(SearchResults.self, from: data)
        
        return searchResponse.searchResults
    }
    
    func searchRecipes(byId id: [Int]) async throws -> [Recipe] {
        var ids = ""
        for (index, recipeId) in id.enumerated() {
            if index < id.count - 1 {
                ids += "\(recipeId),"
            } else {
                ids += "\(recipeId)"
            }
        }
        let urlString = searchByIdUrlString + ids + "&apiKey=" + apiKeys[currentApiKey]
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipesResponse = try JSONDecoder().decode([Recipe].self, from: data)
        
        return recipesResponse
    }
    
    func switchCurrentApiKey() {
        if currentApiKey < apiKeys.count - 1 {
            currentApiKey += 1
        } else {
            currentApiKey = 0
        }
    }
    
}
