//
//  HomePresenterImpl.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

final class HomePresenterImpl: HomePresenter {
    weak var view: (any HomeController)?
    var flowHandler: (() -> Void)?
    
    init(view: any HomeController) {
        self.view = view
    }
    
    func viewDidLoad() {
        
        NetworkService.shared.fetchRecipes()
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            let trendinGrecipe = NetworkService.shared.getTrendingRecipes()
            let countries = NetworkService.shared.getCountries()
            let categories = NetworkService.shared.getCategories()
            let recipeCategories = NetworkService.shared.getRecipeForCountry(categories[0])
            
            
            print(trendinGrecipe)
            guard let self = self else  { return }
            //            self.view?.update(
            //                with: .init(
            //                    tandingNow: .init(
            //                        resepies: trendinGrecipe.enumerated().map() { (index ,recipe) in
            //                            .init(
            //                                recipeid: recipe.id,
            //                                raiting: Double(recipe.rating)!,
            //                                recipeImage: recipe.image ?? URL(string: "https://img.taste.com.au/ir8lOyhk/w643-h428-cfill-q90/taste/2010/01/best-easy-pumpkin-soup-recipe-185570-1.jpg")!,
            //                                recipeName: recipe.title,
            //                                isFavorite: true,
            //                                avtorImage: "person",
            //                                avtorName: "Jessica",
            //                                didSelect:  {
            //                                    print(recipe.id)
            //                                },
            //                                favoriteHandler:  {
            //                                    print(recipe.id)
            //                                }
            //                            )
            //                        },
            //                        headerName: "Trending now",
            //                        seeAllHandler:  {
            //                            print("See all")
            //                        }
            //                    )
            //                )
            //            )
            
            self.view?.update(
                with: .init(
                    tandingNow: .init(
                        resepies: createRecipeCellViewModel(with: trendinGrecipe),
                        header: .init(headerName: "Trending now 🔥",
                                      seeAllHandler: {
                                               print("Tapp Trending see all")
                                           }
                                     )
                    ),
                    popularCategory:
                            .init(
                                resepies: createRecipeCellViewModel(with: recipeCategories),
                                categories: categories.map() { .init(headerName: $0, didSelect: {
                                    print(categories)
                                })},
                                header: .init(
                                    headerName: "Popular category",
                                    seeAllHandler: nil)),
                    recentRecipe: 
                            .init(
                                resepies: [],
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
        
        func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
             let reipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { (index ,recipe) in
                    .init(
                        recipeid: recipe.id,
                        raiting: Double(recipe.rating)!,
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
                        }
                    )
            }
            return reipeModel
        }
    }
}



