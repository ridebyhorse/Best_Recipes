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
    let country: Countries
}

struct TrandingNow {
    let resepies: [RecipesCellViewModel]
    let header: SeeAll
}

struct RecentRecipe {
    let resepies: [RecipesCellViewModel]
    let header: SeeAll
}

struct SeeAll: Identifiable {
    let id = UUID()
    let headerName: String
    let seeAllHandler: (() -> Void)?
}

extension SeeAll: Hashable {
    static func == (lhs: SeeAll, rhs: SeeAll) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PopularCategory {
    let resepies: [RecipesCellViewModel]
    let categories: [Category]
    let header: SeeAll
}

struct Category: Identifiable {
    let id = UUID()
    let headerName: String
    let didSelect: (() -> Void)?
}

extension Category: Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Countries {
    let country: [Country]
    let header: SeeAll
}

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let didSelect: (() -> Void)?
}

extension Country: Hashable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
