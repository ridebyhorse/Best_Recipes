//
//  RecipeDetailController.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RecipeDetailController: UIViewController {
    
    var presenter: RecipeDetailPresenterProtocol?

    private let customView = RecipeView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        presenter?.activate()
    }
}

extension RecipeDetailController: RecipeDetailControllerProtocol {
    func update(with model: RecipeDetailViewModel?) {
        guard let model = model else { return }
        customView.configureView(
            image: model.image,
            title: model.title,
            steps: model.instructions,
            rating: model.rating, 
            reviewsCount: model.reviewsCount
        )
        
        customView.ingredientsTableView.items = model.ingredients
        customView.ingredientsTableView.reloadData()
    }
}
