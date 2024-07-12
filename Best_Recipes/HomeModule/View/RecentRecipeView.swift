//
//  RecentRecipeView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 11.07.24.
//

import UIKit
import SnapKit

//MARK: - RecentRecipeView
final class RecentRecipeView: CellView {
    private let precipeImageView = UIImageView()
    private let nameRecipeLabel = createNameRecipeLabel()
    private let avtorNameLabel = createAvtorNameLabel()
    
    override func configure() {
        setupSubView()
        setupContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

//MARK: - Configgurable impl
extension RecentRecipeView: Configurable {
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            avtorNameLabel.text = nil
            avtorNameLabel.text = nil
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: 10))
        nameRecipeLabel.text = model.recipeName
        avtorNameLabel.text = model.avtorName
    }
}

//MARK: - Private method
private extension RecentRecipeView {
    func setupSubView() {
        addSubviews(precipeImageView, nameRecipeLabel, avtorNameLabel)
    }
    
    func setupContraints() {
        precipeImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(nameRecipeLabel.snp.width)
        }
        
        nameRecipeLabel.snp.makeConstraints { make in
            make.top.equalTo(precipeImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        avtorNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}

//MARK: - Crete and Configure View
private extension RecentRecipeView {
    
    static func createNameRecipeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .custom(font: .bold, size: 14)
        label.textAlignment = .left
        return label
    }
    
    static func createAvtorNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 12)
        label.textColor = .darkGreyApp
        return label
    }
}
