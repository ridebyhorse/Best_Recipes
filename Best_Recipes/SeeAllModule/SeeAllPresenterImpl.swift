//
//  SeeAllPresenterImpl.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import Foundation

final class SeeAllPresenterImpl: SeeAllPresenter {
    
    var country: String?
    var recipesForCountry = [Recipe]() {
        didSet {
            seeAllViewModel = .init(
                    countries: .init(countries.map() { countryName in
                            .init(headerName: countryName, didSelect: { [weak self ] in
                                
                                self?.country = countryName
                                self?.viewDidLoad()
                                print(self?.country)
                                print(self?.recipesForCountry.map({$0.title}))
                            })
                    }
                    ),
                    recipes: createRecipeCellViewModel(with: recipesForCountry),
                    mode: mode
            )
        }
    }
    var mode: SeeAllMode
    var detailFlowHandler: ((Int) -> Void)?
    weak var view: (any SeeAllController)?
    let networkManager = NetworkManager.shared
    private var seeAllViewModel: SeeAllViewModel? {
        didSet {
            view?.update(with: seeAllViewModel)
        }
    }
    var countries = [String]()
    
    init(view: any SeeAllController, mode: SeeAllMode) {
        self.view = view
        self.mode = mode
        if mode == .countries {
            countries = networkManager.getCountries()
        }
    }
    
    func viewDidLoad() {
        switch mode {
        case .countries:
            updateSeeAllCountries()
        case .recent:
            updateSeeAllRecent()
        case .trending:
            updateSeeAllTrending()
        case .certainCountry:
            updateSeeAllCertainCountry()
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
                        StorageService.shared.toggleFavorite(recipeId: recipe.id!)
                        self.updateFavs()
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        let fav = StorageService.shared.getFavoriteRecipes()
        return updateFavoriteStatus(in: recipeModel, with: fav)
    }
    
    private func updateFavs() {
        let fav = StorageService.shared.getFavoriteRecipes()
        guard let seeAllViewModel = seeAllViewModel else { return }
        let updatedRecipes = updateFavoriteStatus(in: seeAllViewModel.recipes, with: fav)
        let newModel = SeeAllViewModel.init(countries: seeAllViewModel.countries, recipes: updatedRecipes, mode: seeAllViewModel.mode)
        self.seeAllViewModel = newModel
    }
    
    private func updateSeeAllCountries() {
        if let country {
            recipesForCountry = networkManager.getRecipeForCountry(country)
        } else {
            recipesForCountry = networkManager.getRecipeForCountry(countries[0])
        }
        
    }
    
    private func updateSeeAllCertainCountry() {
        let recipes = networkManager.getRecipeForCountry(country!)
        seeAllViewModel = .init(
                countries: [SeeAllCountry](),
                recipes: createRecipeCellViewModel(with: recipes),
                mode: mode
        )
    }
    
    private func updateSeeAllTrending() {
        let recipes = networkManager.getTrendingRecipes()
        seeAllViewModel = .init(
                countries: [SeeAllCountry](),
                recipes: createRecipeCellViewModel(with: recipes),
                mode: mode
        )
    }
    
    private func updateSeeAllRecent() {
        let recipes = StorageService.shared.getRecentRecipes()
        seeAllViewModel = .init(
                countries: [SeeAllCountry](),
                recipes: createRecipeCellViewModel(with: recipes),
                mode: mode
        )
    }
    
    func updateFavoriteStatus(in recipes: [RecipesCellViewModel], with favoriteRecipes: [Recipe]) -> [RecipesCellViewModel] {
        var updatedRecipes = recipes
        let favoriteIds = Set(favoriteRecipes.map { $0.id })
        
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


