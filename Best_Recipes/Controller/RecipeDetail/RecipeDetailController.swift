//
//  RecipeDetailController.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RecipeDetailController: UIViewController {
    
    private let customView = RecipeView()
    
    override func loadView() {
        view = customView
    }
    
}

@available(iOS 17.0, *) 
#Preview {
    RecipeDetailController()
}
