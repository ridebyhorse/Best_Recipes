//
//  NetworkManager.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 03.07.2024.
//

import Foundation

class NetworkManager {
    
    private let networkService: NetworkService
    private var recipes = [Recipe]()
    private var searchId = [Int]()
    
    static let shared = NetworkManager.init(networkService: NetworkService.shared)
    
    private init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRecipes() {
        Task {
            do {
                var result = try await networkService.fetchRecipes()
                configureRecipes(&result)
                let filteredRecipes = result.filter({ $0.ingredients != nil })
                for filteredRecipe in filteredRecipes {
                    if !recipes.contains(where: {$0.id == filteredRecipe.id}) {
                        recipes.append(filteredRecipe)
                    }
                }
            } catch {
                print("Ошибка при загрузке рецептов: \(error)")
                networkService.switchCurrentApiKey()
            }
        }
    }
    
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
    
    func getRecipesByKeyword(_ keyword: String) -> [Recipe] {
        let searchedRecipes = UnsafeTask {
            await self.searchRecipes(byKeyword: keyword)
        }.get()
        
        for recipe in searchedRecipes {
            if !recipes.contains(where: {$0.id == recipe.id}) {
                recipes.append(recipe)
            }
        }
        
        return searchedRecipes
    }
    
    func getRecipeById(_ id: Int) -> Recipe? {
        let mockRecipes = MockData.getMockRecipesMore()!
        if let index = recipes.firstIndex(where: {$0.id == id}) {
            return recipes[index]
        } else if let mockIndex = mockRecipes.firstIndex(where: {$0.id == id}) {
            return mockRecipes[mockIndex]
        } else {
            return nil
        }
    }
    
    func updateFav(id: Int) {
        if let index = recipes.firstIndex(where: {$0.id == id}) {
            recipes[index].isFavorite.toggle()
        }
    }
    
    private func searchRecipes(byKeyword keyword: String) async -> [Recipe] {
        await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {
                if let searchedRecipes = await self.fetchRecipes(byKeyword: keyword).first.map({$0.results}) {
                    let ids = searchedRecipes.map({$0.id})
                    for id in ids {
                        if let id {
                            self.searchId.append(id)
                        }
                    }
                }
            }
        }
        
        var searchedRecipes = UnsafeTask {
            await self.fetchRecipes(byId: self.searchId)
        }.get()
        
        configureRecipes(&searchedRecipes)
        
        return searchedRecipes
    }
    
    private func fetchRecipes(byKeyword keyword: String) async -> [SearchResult] {
        var result = [SearchResult]()
        
        do {
            result = try await networkService.searchRecipes(byKeyword: keyword)
            return result.filter({ $0.name == "Recipes" })
        } catch {
            print("Ошибка при поиске рецептов: \(error)")
            networkService.switchCurrentApiKey()
        }
        
        return result
    }
    
    private func fetchRecipes(byId id: [Int]) async -> [Recipe] {
        var result = [Recipe]()
        
            do {
                result = try await networkService.searchRecipes(byId: id)
                searchId = []
                return result
            } catch {
                print("Ошибка при поиске рецептов: \(error)")
                networkService.switchCurrentApiKey()
            }
        
        return result
    }
    
    private func configureRecipes(_ recipes: inout [Recipe]) {
        for var recipe in recipes {
            recipe.rating /= 20.0
            for var ingridient in recipe.ingredients! {
                if let image = ingridient.image {
                    ingridient.image = "https://img.spoonacular.com/ingredients_100x100/" + image
                }
            }
        }
    }

}
