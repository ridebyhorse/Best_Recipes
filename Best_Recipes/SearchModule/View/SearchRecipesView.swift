//
//  SearchRecipesView.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 06.07.2024.
//

import UIKit
import SnapKit

final class SearchRecipesView: CellView, Configurable {
    
    private let recipeImageView: UIImageView = {
        let recipeImageView = UIImageView()
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.addoverlay(alpha: 0.4)
        
        return recipeImageView
    }()
    
    private let ratingView: UIView = {
        let ratingView = UIView()
        ratingView.backgroundColor = .darkGreyApp.withAlphaComponent(0.4)
        ratingView.layer.cornerRadius = 8
        ratingView.clipsToBounds = true
        
        return ratingView
    }()
    
    private let starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.image = UIImage(imageLiteralResourceName: "Star")
        starImage.contentMode = .scaleAspectFit
        
        return starImage
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .custom(font: .bold, size: 14)
        ratingLabel.textColor = .white
        
        return ratingLabel
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .custom(font: .bold, size: 20)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    private let ingridientsLabel: UILabel = {
        let ingridientsLabel = UILabel()
        ingridientsLabel.font = .custom(font: .regular, size: 12)
        ingridientsLabel.textColor = .white
        
        return ingridientsLabel
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        
        return separator
    }()
    
    private let cookTimeLabel: UILabel = {
        let cookTimeLabel = UILabel()
        cookTimeLabel.font = .custom(font: .regular, size: 12)
        cookTimeLabel.textColor = .white
        
        return cookTimeLabel
    }()
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            recipeImageView.update(with: nil)
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = -20
        titleLabel.attributedText = NSAttributedString(string: "\(model.recipeName)", attributes: [.paragraphStyle: paragraphStyle])
        recipeImageView.update(with: .init(url: model.recipeImage, cornerRadius: 10))
        ratingLabel.text = String(format: "%.1f", model.raiting / 20.0)
        ingridientsLabel.text = String(model.ingridientsCount) + "ingridients"
        cookTimeLabel.text = calculateCookTime(mins: model.coockingTime)
    }
    
    override func configure() {
        addSubviews(recipeImageView, ratingView, titleLabel, ingridientsLabel, separator, cookTimeLabel)
        ratingView.addSubviews(starImage, ratingLabel)
        
        recipeImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.width.equalTo(58)
            make.height.equalTo(28)
        }
        
        starImage.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(7)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(36)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(17)
        }
        
        ingridientsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(15)
        }
        
        separator.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(18)
            make.centerY.equalTo(ingridientsLabel)
            make.leading.equalTo(ingridientsLabel.snp.trailing).offset(7)
        }
        
        cookTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(ingridientsLabel)
            make.leading.equalTo(separator.snp.trailing).offset(7)
        }
    }
    
    private func calculateCookTime(mins: Int) -> String {
        let hours = mins / 60
        let minutes = mins % 60
        if hours > 0 {
            return "\(hours) h \(minutes) min"
        } else {
            return "\(minutes) min"
        }
    }
}
