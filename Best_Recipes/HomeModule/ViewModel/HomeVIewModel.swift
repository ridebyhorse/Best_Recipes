//
//  HomeVIewModel.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

struct HomeViewModel {
    struct TrandingNow {
        let resepies: [RecipesCellViewModel]
        let headerName: String
        let seeAllHandler: () -> Void
    }
    
    let tandingNow: TrandingNow
    
}

