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
    private var searchCountryId = [Int]()
    
    static let shared = NetworkManager.init(networkService: NetworkService.shared)
    
    private init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRecipes() async {
        var attempts = 3
        while attempts > 0 {
            do {
                let result = try await networkService.fetchRecipes()
                let filteredRecipes = result.filter { $0.ingredients != nil }
                for filteredRecipe in filteredRecipes {
                    if !recipes.contains(where: { $0.id == filteredRecipe.id }) {
                        recipes.append(filteredRecipe)
                    }
                }
                attempts -= 1 // Reduce the attempt count after a successful fetch
            } catch {
                print("Ошибка при загрузке рецептов: (error)")
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
        
        return categories.removingDuplicates()
    }
    
    func getRecipeForCategory(_ category: String) -> [Recipe] {
        recipes.filter({ $0.categories.contains(category) })
    }
    
    func getCountries() -> [String] {
        var countries = [String]()
        recipes.forEach({
            countries += $0.countries
        })
        
        return countries.removingDuplicates()
    }
    
    func getRecipeForCountry(_ country: String) -> [Recipe] {
        let searchedRecipes = UnsafeTask {
            await self.searchRecipes(byCountry: country)
        }.get()
        
        for recipe in searchedRecipes {
            if !recipes.contains(where: {$0.id == recipe.id}) {
                recipes.append(recipe)
            }
        }
        
        return searchedRecipes
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
        
        let searchedRecipes = UnsafeTask {
            await self.fetchRecipes(byId: self.searchId)
        }.get()
        
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
    
    private func searchRecipes(byCountry country: String) async -> [Recipe] {
        await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {
                let searchedRecipes = await self.fetchRecipes(byCountry: country)
                let ids = searchedRecipes.map({$0.id})
                
                for id in ids {
                    if let id {
                        self.searchCountryId.append(id)
                    }
                }
            }
        }
        
        let searchedRecipes = UnsafeTask {
            await self.fetchRecipes(byId: self.searchCountryId)
        }.get()
        
        return searchedRecipes
    }
    
    private func fetchRecipes(byCountry country: String) async -> [CountryResult] {
        var result = [CountryResult]()
        
        do {
            result = try await networkService.searchRecipesForCountry(country: country)
            return result
        } catch {
            print("Ошибка при поиске рецептов по кухне \(country): \(error)")
            networkService.switchCurrentApiKey()
        }
        
        return result
    }
    
    private func fetchRecipes(byId id: [Int]) async -> [Recipe] {
        var result = [Recipe]()
        
            do {
                result = try await networkService.searchRecipes(byId: id)
                searchId = []
                searchCountryId = []
                return result
            } catch {
                print("Ошибка при поиске рецептов по id: \(error)")
                networkService.switchCurrentApiKey()
            }
        
        return result
    }
}
