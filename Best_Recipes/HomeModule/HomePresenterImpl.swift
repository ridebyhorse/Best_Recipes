//
//  HomePresenterImpl.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

final class HomePresenterImpl: HomePresenter {
    let networkManager: NetworkManager
    let storageService: StorageService
    var flowHandler: HomeNavigationHandler?
    weak var view: (any HomeController)?
    private var category = ""
    
    private var homeViewModel: HomeViewModel?  = nil {
        didSet {
            view?.update(with: homeViewModel)
        }
    }
    
    init(view: any HomeController, storageService: StorageService, networkManager: NetworkManager) {
        self.view = view
        self.storageService = storageService
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        Task {
            await networkManager.fetchRecipes()
            self.category = networkManager.getCategories().first!
            await firstLoad()
        }
    }
    
    @MainActor
    func viewDidApear() {
        self.reloadData()
    }
    
    @MainActor
    func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
        let favorite = StorageService.shared.getFavoriteRecipes()
        let favoriteIds = Set(favorite.map { $0.id })
        let reipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { [unowned self] ( index ,recipe) in
                .init(
                    recipeid: recipe.id!,
                    raiting: recipe.rating,
                    recipeImage: recipe.image ?? URL(string: "https://img.taste.com.au/ir8lOyhk/w643-h428-cfill-q90/taste/2010/01/best-easy-pumpkin-soup-recipe-185570-1.jpg")!,
                    recipeName: recipe.title,
                    isFavorite: favoriteIds.contains(recipe.id!),
                    avtorImage: "person",
                    avtorName: "Jessica",
                    coockingTime: recipe.cookingTime,
                    didSelect:  {
                        print("didSelect")
                        self.flowHandler?(.recipe(recipeId: recipe.id!))
                    },
                    favoriteHandler:  {
                        storageService.toggleFavorite(recipeId: recipe.id!)
                        self.reloadData()
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        return reipeModel
    }
    
    @MainActor
    func firstLoad() {
        let trendingRecipe = networkManager.getTrendingRecipes()
        let categoryRecipe = networkManager.getRecipeForCategory(self.category)
        let recipe = self.networkManager.getTrendingRecipes()
        let categories = networkManager.getCategories()
        let countries = networkManager.getCountries()
        
        self.homeViewModel = .init(
            tandingNow: .init(
                resepies: createRecipeCellViewModel(with: trendingRecipe),
                header: .init(headerName: "Trending now 🔥",
                              seeAllHandler: {
                                  self.flowHandler?(.seeAll(mode: .trending))
                              }
                             )
            ),
            popularCategory:
                    .init(
                        resepies: createRecipeCellViewModel(with: categoryRecipe),
                        categories: categories.map() { catName in
                                .init(headerName: catName, didSelect: { [weak self ] in
                                    
                                    self?.category = catName
                                    self?.reloadData()
                                })
                        },
                        header: .init(headerName: "Popular category",
                                      seeAllHandler: nil)
                    ),
            recentRecipe:
                    .init(
                        resepies: createRecipeCellViewModel(with: storageService.getRecentRecipes()),
                        header: .init(headerName: "Recent recipe",
                                      seeAllHandler: {
                                          self.flowHandler?(.seeAll(mode: .recent))
                                      }
                                     )
                    ),
            country:
                    .init(
                        country: countries.map() { country in
                                .init(name: country, imageName: country, didSelect: {
                                    print(country)
                                    self.flowHandler?(.seeAllCertainCountry(country: country))
                                })
                        },
                        header: .init(headerName: "Popular cusines",
                                      seeAllHandler: {
                                          self.flowHandler?(.seeAll(mode: .countries))
                                      }
                                     )
                    )
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
    
    @MainActor
    func reloadData() {
        guard let homeViewModel = homeViewModel else { return }
        let categoryRecipe = networkManager.getRecipeForCategory(self.category)
        let favorite = storageService.getFavoriteRecipes()
        
        let trendingNow = TrandingNow.init(resepies: updateFavoriteStatus(in: homeViewModel.tandingNow.resepies, with: favorite), header: homeViewModel.tandingNow.header)
        let recentRecipe = RecentRecipe.init(resepies: createRecipeCellViewModel(with: storageService.getRecentRecipes()), header: homeViewModel.recentRecipe.header)
        let popularCategory = PopularCategory(resepies: createRecipeCellViewModel(with: categoryRecipe), categories: homeViewModel.popularCategory.categories, header: homeViewModel.popularCategory.header)
        let country = homeViewModel.country
        
        self.homeViewModel = .init(tandingNow: trendingNow, popularCategory: popularCategory, recentRecipe: recentRecipe, country: country)
    }
}
