//
//  SeeAllViewModel.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import Foundation

enum SeeAllMode: String {
    case trending = "Trending now 🔥"
    case recent = "Recent recipes"
    case countries = "Popular cusines"
}

struct SeeAllViewModel {
    let countries: [SeeAllCountry]
    let recipes: [RecipesCellViewModel]
    let mode: SeeAllMode
}

struct SeeAllCountry: Hashable, Identifiable {
    let id = UUID()
    let headerName: String
    let didSelect: (() -> Void)?
    
    static func == (lhs: SeeAllCountry, rhs: SeeAllCountry) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


