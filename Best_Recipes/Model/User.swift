//
//  User.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 11.07.2024.
//

import Foundation

struct User: Codable {
    var name: String
    var location: String
    var recipesCreated: Int
}
