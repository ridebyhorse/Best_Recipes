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
            let recipe = NetworkService.shared.getTrendingRecipes()
            print(recipe)
            guard let self = self else  { return }
            self.view?.update(
                with: .init(
                    tandingNow: .init(
                        resepies: recipe.enumerated().map() { (index ,recipe) in
                            .init(
                                id: recipe.id,
                                raiting: Double(recipe.rating)!,
                                recipeImage: recipe.image ?? URL(string: "https://img.taste.com.au/ir8lOyhk/w643-h428-cfill-q90/taste/2010/01/best-easy-pumpkin-soup-recipe-185570-1.jpg")!,
                                recipeName: recipe.title,
                                isFavorite: true,
                                avtorImage: "person",
                                avtorName: "Jessica",
                                didSelect:  {
                                    print(recipe.id)
                                },
                                favoriteHandler:  {
                                    print(recipe.id)
                                }
                            )
                        },
                        headerName: "Trending now",
                        seeAllHandler:  {
                            print("See all")
                        }
                    )
                )
            )
        }
    }
}
