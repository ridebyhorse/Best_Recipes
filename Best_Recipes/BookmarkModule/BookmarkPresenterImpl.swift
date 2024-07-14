//
//  BookmarkPresenterImpl.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 11.07.2024.
//

import Foundation

final class BookmarkPresenterImpl: BookmarkPresenter {
    
    var detailFlowHandler: ((Int) -> Void)?
    weak var view: (any BookmarkController)?
    let storageManager = StorageService.shared
    private var recipes = [Recipe]()
    
    init(view: any BookmarkController) {
        self.view = view
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
                    didSelect:  { [weak self] in
                        self?.detailFlowHandler?(recipe.id!)
                    },
                    favoriteHandler:  { [weak self] in
                        if recipe.isFavorite {
                            print("\(recipe.id!) Recipe \(recipe.title) removed from favorites")
                        } else {
                            print("\(recipe.id!) Recipe \(recipe.title) added to favorites")
                        }
                        self?.storageManager.toggleFavorite(recipeId: recipe.id)
                        self?.viewDidLoad()
                    },
                    ingridientsCount: recipe.ingredients?.count ?? 0
                )
        }
        return recipeModel
    }
    
    func viewDidLoad() {
        recipes = storageManager.getFavoriteRecipes()

        view?.update(
            with: .init(
                favoriteRecipes: createRecipeCellViewModel(with: recipes)
            )
        )
    }
}
