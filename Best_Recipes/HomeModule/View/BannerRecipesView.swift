//
//  BannerRecipesView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit
final class BannerRecipesView: CellView, Configurable {
    private let precipeImageView = UIImageView()
    private let nameRecipeLabel = UILabel()
    
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage, cornerRadius: 10 ))
        backgroundColor = .systemGray
        
    }
    
    override func configure() {
        addSubviews(precipeImageView, nameRecipeLabel)
        
        
        precipeImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
        
        nameRecipeLabel.snp.makeConstraints { make in
            make.top.equalTo(precipeImageView).offset(10)
            make.leading.equalToSuperview()
            
        }
    }
    
}
//@available(iOS 17.0, *)
//#Preview {
//    UINavigationController(rootViewController: CustomTabBarController())
//}



@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ModuleFactory().createHomeModule(flowHandler: nil))
}

