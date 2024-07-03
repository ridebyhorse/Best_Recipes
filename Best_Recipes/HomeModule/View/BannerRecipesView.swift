//
//  BannerRecipesView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit
final class BannerRecipesView: CustomView, Configurable {
    let precipeImageView = UIImageView()
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage ))
        backgroundColor = .black
        
    }
    
    override func configure() {
        addSubview(precipeImageView)
        precipeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
}
