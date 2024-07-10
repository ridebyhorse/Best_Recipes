//
//  HomePresenterImpl.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

final class HomePresenterImpl: HomePresenter, FlowProtocol {
    
    weak var view: (any HomeController)?
    var flowHandler: (() -> Void)?
    let networkManager = NetworkManager(networkService: NetworkService.shared)
    
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
            let countries = ["Gb", "DE","Gb", "DE","Gb", "DE","Gb", "DE","Gb", "DE","Gb", "DE","Gb", "DE"]
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
                                              self.flowHandler?()
                                              print("Tapp Trending see all")
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
                                    header: .init(
                                        headerName: "Recent recipe",
                                        seeAllHandler: nil)),
                        country:
                                .init(
                                    country: countries.map() { country in
                                            .init(name: country, imageName: country, didSelect: { print(country)})
                                    },
                                    header: .init(
                                        headerName: "Country",
                                        seeAllHandler: nil)
                                )
                    )
                )
            }
            
        }
        
        func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
            let reipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { (index ,recipe) in
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
                            print(recipe.id)
                        },
                        favoriteHandler:  {
                            print(recipe.id)
                        },
                        ingridientsCount: recipe.ingredients?.count ?? 0
                    )
            }
            return reipeModel
        }
    }
}


