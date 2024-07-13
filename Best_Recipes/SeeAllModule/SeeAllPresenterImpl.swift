//
//  SeeAllPresenterImpl.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import Foundation

final class SeeAllPresenterImpl: SeeAllPresenter {
    
    var mode: SeeAllMode
    var detailFlowHandler: ((Int) -> Void)?
    weak var view: (any SeeAllController)?
    let networkManager = NetworkManager.shared
    private var seeAllViewModel: SeeAllViewModel? {
        didSet {
            view?.update(with: seeAllViewModel)
        }
    }
    
    var favorites = [Int]()
    
    init(view: any SeeAllController, mode: SeeAllMode) {
        self.view = view
        self.mode = mode
    }
    
    func viewDidLoad() {
        switch mode {
        case .countries:
            updateSeeAllCountries()
        default:
            updateSeeAll()
        }
    }
    
    private func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
        let recipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { [unowned self] ( index ,recipe) in
           
                .init(
                    recipeid: recipe.id!,
                    raiting: recipe.rating,
                    recipeImage: recipe.image ?? URL(string: "https://img.taste.com.au/ir8lOyhk/w643-h428-cfill-q90/taste/2010/01/best-easy-pumpkin-soup-recipe-185570-1.jpg")!,
                    recipeName: recipe.title,
                    isFavorite: recipe.isFavorite,
                    avtorImage: recipe.author,
                    avtorName: recipe.author,
                    coockingTime: recipe.cookingTime,
                    didSelect:  {
                        print("didSelect")
                        self.detailFlowHandler?(recipe.id!)
                    },
                    favoriteHandler:  {
                        StorageService.shared.toggleFavorite(recipeId: recipe.id)
                        self.favorites.append(recipe.id!)
                        switch self.mode {
                        case .countries:
                            self.updateSeeAllCountries()
                        default:
                            self.updateSeeAll()
                        }
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        
        let favorite = StorageService.shared.getFavoriteRecipes()
        print(favorite)
        
        return updateFavoriteStatus(in: recipeModel, with: self.favorites)
    }
    
    private func updateSeeAllCountries() {
        var recipes = MockData.getMockRecipesMore()!
        var countries = [String]()
        recipes.forEach({
            countries += $0.countries
        })
        countries = countries.removingDuplicates()
        
        view?.update(
            with: .init(
                countries: countries.map() { .init(headerName: $0, didSelect: { print(countries) }) },
                recipes: createRecipeCellViewModel(with: recipes),
                mode: mode
            )
        )
    }
    
    private func updateSeeAll() {
        var recipes = MockData.getMockRecipesMore()!
        view?.update(
            with: .init(
                countries: [SeeAllCountry](),
                recipes: createRecipeCellViewModel(with: recipes),
                mode: mode
            )
        )
    }
    
    private func updateFavoriteStatus(in recipes: [RecipesCellViewModel], with favoriteRecipes: [Int]) -> [RecipesCellViewModel] {
        var updatedRecipes = recipes
        let favoriteIds = Set(favoriteRecipes.map { $0 })
        
        for i in 0..<updatedRecipes.count {
            if favoriteIds.contains(updatedRecipes[i].recipeid) {
                updatedRecipes[i].isFavorite = true
            } else {
                updatedRecipes[i].isFavorite = false
            }
        }
        
        return updatedRecipes
    }
}


