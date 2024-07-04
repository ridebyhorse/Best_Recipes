//
//  BookmarkViewController.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    let nm = NetworkManager(networkService: NetworkService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        nm.fetchRecipes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            print(self?.nm.getCategories())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            print(self?.nm.getRecipesByKeyword("apple").map({$0.title}))
        }
    }
    
    
    
}
