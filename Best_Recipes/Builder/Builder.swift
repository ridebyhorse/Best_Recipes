//
//  Builder.swift
//  Best_Recipes
//
//  Created by Natalia on 03.07.2024.
//

import UIKit

final class Builder {
    
    static func createRecipeScreen() -> UIViewController {
        RecipeDetailsAssembly().build()
    }
}
