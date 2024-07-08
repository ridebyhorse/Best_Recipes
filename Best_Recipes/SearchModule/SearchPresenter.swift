//
//  SearchPresenter.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 06.07.2024.
//

import Foundation

final class SearchPresenterImpl: SearchPresenter {
    weak var view: (any SearchController)?
    var flowHandler: (() -> Void)?
    let networkManager = NetworkManager(networkService: NetworkService.shared)
    private var recipes = [Recipe]() {
        didSet {
            view?.update(
                with: .init(
                    searchedRecipes: createRecipeCellViewModel(with: recipes)
                    
                )
            )
        }
    }
    
    init(view: any SearchController) {
        self.view = view
    }
    
    func searchRecipeByKeyword(_ keyword: String) {
        recipes = networkManager.getRecipesByKeyword(keyword)
    }
    
    private func createRecipeCellViewModel(with recipes: [Recipe]) -> [RecipesCellViewModel] {
        let recipeModel: [RecipesCellViewModel] = recipes.enumerated().map() { (index ,recipe) in
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
                        //DETAIL SCREEN
                        print(recipe.id)
                    },
                    favoriteHandler:  {
                        print(recipe.id)
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        return recipeModel
    }
}
