//
//  HomePresenterImpl.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

final class HomePresenterImpl: HomePresenter {
    var flowHandler: HomeNavigationHandler?
    weak var view: (any HomeController)?
    let networkManager = NetworkManager.shared
    private var homeViewModel: HomeViewModel? {
        didSet {
            view?.update(with: homeViewModel)
        }
    }
    
    var x = [Int]()
    
    init(view: any HomeController) {
        self.view = view
    }
    
    func viewDidLoad() {
//        networkManager.fetchRecipes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
//            let trendingRecipe = self?.networkManager.getTrendingRecipes()
//            let countries = self?.networkManager.getCountries()
//            let categories = self?.networkManager.getCategories()
//            let recipeCategories = self?.networkManager.getRecipeForCategory(categories![0])
            
            let trendingRecipe = MockData.getMockRecipesMore()
            var countries = [String]()
            trendingRecipe!.forEach({
                countries += $0.countries
            })
            countries = countries
            let categories =  ["v", "Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst",]
            let recipeCategories = MockData.getMockRecipesMore()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
                let recipe = self?.networkManager.getTrendingRecipes()
                
                guard let self = self else  { return }
                self.view?.update(
                    with: .init(
                        tandingNow: .init(
                            resepies: createRecipeCellViewModel(with: trendingRecipe!),
                            header: .init(headerName: "Trending now 🔥",
                                          seeAllHandler: {
                                              self.flowHandler?(.seeAll(mode: .trending))
                                          }
                                         )
                        ),
                        popularCategory:
                                .init(
                                    resepies: createRecipeCellViewModel(with: recipeCategories!),
                                    categories: categories.map() { .init(headerName: $0, didSelect: {
                                        print(categories)
                                    })},
                                    header: .init(
                                        headerName: "Popular category",
                                        seeAllHandler: nil)),
                        recentRecipe:
                                .init(
                                    resepies: createRecipeCellViewModel(with: trendingRecipe!),
                                    header: .init(headerName: "Recent recipe",
                                                  seeAllHandler: {
                                                      self.flowHandler?(.seeAll(mode: .recent))
                                                  }
                                                 )
                                ),
                        country:
                                .init(
                                    country: countries.map() { country in
                                            .init(name: country, imageName: country, didSelect: { print(country)})
                                    },
                                    header: .init(headerName: "Popular cusines",
                                                  seeAllHandler: {
                                                      self.flowHandler?(.seeAll(mode: .countries))
                                                  }
                                                 )
                                )
                    )
                )
            }
            
        }
      
    }
    
    func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
        let reipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { [unowned self] ( index ,recipe) in
           
                .init(
                    recipeid: recipe.id!,
                    raiting: recipe.rating,
                    recipeImage: recipe.image ?? URL(string: "https://img.taste.com.au/ir8lOyhk/w643-h428-cfill-q90/taste/2010/01/best-easy-pumpkin-soup-recipe-185570-1.jpg")!,
                    recipeName: recipe.title,
                    isFavorite: true,
                    avtorImage: "person",
                    avtorName: "Jessica",
                    coockingTime: recipe.cookingTime,
                    didSelect:  {
                        print("didSelect")
                        self.flowHandler?(.recipe(recipeId: recipe.id!))
                    },
                    favoriteHandler:  {
                        StorageService.shared.toggleFavorite(recipeId: recipe.id!)
                        print("favoriteHandler")
                        self.x.append(recipe.id!)
                        
                        self.aaa()
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        
        let favorite = StorageService.shared.getFavoriteRecipes()
        print(favorite)
        
        return updateFavoriteStatus(in: reipeModel, with: self.x)
    }
    func aaa() {
        
        let trendingRecipe = MockData.getMockRecipesMore()
        var countries = [String]()
        trendingRecipe!.forEach({
            countries += $0.countries
        })
        countries = Array(Set(countries))
        let categories =  ["v", "Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst","Breackfst",]
        let recipeCategories = MockData.getMockRecipesMore()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
            let recipe = self?.networkManager.getTrendingRecipes()
            
            guard let self = self else  { return }
            self.view?.update(
                with: .init(
                    tandingNow: .init(
                        resepies: createRecipeCellViewModel(with: trendingRecipe!),
                        header: .init(headerName: "Trending now 🔥",
                                      seeAllHandler: {
                                          self.flowHandler?(.seeAll(mode: .trending))
                                      }
                                     )
                    ),
                    popularCategory:
                            .init(
                                resepies: createRecipeCellViewModel(with: recipeCategories!),
                                categories: categories.map() { .init(headerName: $0, didSelect: {
                                    print(categories)
                                })},
                                header: .init(headerName: "Popular category",
                                              seeAllHandler: nil)
                            ),
                    recentRecipe:
                            .init(
                                resepies: createRecipeCellViewModel(with: trendingRecipe!),
                                header: .init(headerName: "Recent recipe",
                                              seeAllHandler: {
                                                  self.flowHandler?(.seeAll(mode: .recent))
                                              }
                                             )
                            ),
                    country:
                            .init(
                                country: countries.map() { country in
                                        .init(name: country, imageName: country, didSelect: { print(country)})
                                },
                                header: .init(headerName: "Popular cusines",
                                              seeAllHandler: {
                                                  self.flowHandler?(.seeAll(mode: .countries))
                                              }
                                             )
                            )
                )
            )
        }
    }
    
    func updateFavoriteStatus(in recipes: [RecipesCellViewModel], with favoriteRecipes: [Int]) -> [RecipesCellViewModel] {
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


