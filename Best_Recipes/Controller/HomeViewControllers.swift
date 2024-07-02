//
//  HomeViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        NetworkService.shared.fetchRecipes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let categories: [String]
            let countries: [String]
            print("/////////////////TRENDING RECIPES////////////////////")
            print(NetworkService.shared.getTrendingRecipes())
            print("/////////////////CATEGORIES////////////////////")
            categories = NetworkService.shared.getCategories()
            print(categories)
            for category in categories {
                print("/////////////////RECIPES IN CATEGORY \(category.uppercased())////////////////////")
                print(NetworkService.shared.getRecipeForCategory(category))
            }
            print("/////////////////COUNTRIES////////////////////")
            countries = NetworkService.shared.getCountries()
            print(countries)
            for country in countries {
                print("/////////////////RECIPES FOR COUNTRY \(country.uppercased())////////////////////")
                print(NetworkService.shared.getRecipeForCountry(country))
            }
        }
    }
    
}
