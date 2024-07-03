//
//  HomeVIewModel.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import Foundation

struct HomeViewModel {
    let tandingNow: TrandingNow
    let popularCategory: PopularCategory
    let recentRecipe: RecentRecipe
    let country: Country
}


struct TrandingNow {
    let resepies: [RecipesCellViewModel]
    let header: SeeAll
}

struct RecentRecipe {
    let resepies: [RecipesCellViewModel]
    let header: SeeAll
}

struct SeeAll: Hashable, Identifiable {
    let id = UUID()
    let headerName: String
    let seeAllHandler: (() -> Void)?
    
    static func == (lhs: SeeAll, rhs: SeeAll) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PopularCategory {
    let resepies: [RecipesCellViewModel]
    let categories: [Categories]
    let header: SeeAll
}

struct Categories: Hashable, Identifiable {
    let id = UUID()
    let headerName: String
    let didSelect: (() -> Void)?
    
    static func == (lhs: Categories, rhs: Categories) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Country {
    let country: [Countries]
    let header: SeeAll
}

struct Countries: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let didSelect: (() -> Void)?
    
    static func == (lhs: Countries, rhs: Countries) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
