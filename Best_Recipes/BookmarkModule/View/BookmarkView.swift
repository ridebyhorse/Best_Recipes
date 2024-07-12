//
//  BookmarkView.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 11.07.2024.
//

import Foundation

import UIKit
import SnapKit

final class BookmarkView: CellView, Configurable {
    
    private var onFavTap: (() -> Void)?
    
    private let recipeImageView: UIImageView = {
        let recipeImageView = UIImageView()
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.tintColor = .darkGreyApp.withAlphaComponent(0.2)
        
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
    
    private lazy var favButton: UIButton = {
        let favButton = UIButton()
        favButton.imageView?.contentMode = .scaleAspectFit
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        
        return favButton
    }()
    
    private let cookTimeView: UIView = {
        let cookTimeView = UIView()
        cookTimeView.backgroundColor = .darkGreyApp.withAlphaComponent(0.4)
        cookTimeView.layer.cornerRadius = 8
        cookTimeView.clipsToBounds = true
        
        return cookTimeView
    }()
    
    private let cookTimeLabel: UILabel = {
        let cookTimeLabel = UILabel()
        cookTimeLabel.font = .custom(font: .regular, size: 12)
        cookTimeLabel.textColor = .white
        
        return cookTimeLabel
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .custom(font: .bold, size: 16)
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    private let authorImageView: UIImageView = {
        let authorImageView = UIImageView()
        authorImageView.contentMode = .scaleAspectFill
        
        return authorImageView
    }()
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .custom(font: .regular, size: 12)
        authorLabel.textColor = .darkGreyApp
        
        return authorLabel
    }()
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            recipeImageView.update(with: nil)
            return
        }
        if model.isFavorite {
            favButton.setImage(UIImage(imageLiteralResourceName: "fav"), for: .normal)
        } else {
            favButton.setImage(UIImage(imageLiteralResourceName: "fav_disabled"), for: .normal)
        }
        titleLabel.text = model.recipeName
        recipeImageView.update(with: .init(url: model.recipeImage, cornerRadius: 10))
        ratingLabel.text = String(format: "%.1f", model.raiting / 20.0)
        cookTimeLabel.text = calculateCookTime(mins: model.coockingTime)
        authorImageView.update(with: .init(image: UIImage(imageLiteralResourceName: "author" + String(Int.random(in: 0...9))), cornerRadius: 16))
        authorLabel.text = model.avtorName
        onFavTap = model.favoriteHandler
    }
    
    override func configure() {
        addSubviews(recipeImageView, ratingView, favButton, cookTimeView, cookTimeLabel, titleLabel, authorImageView, authorLabel)
        ratingView.addSubviews(starImage, ratingLabel)
        
        recipeImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-12)
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
        
        favButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(32)
        }
        
        cookTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(cookTimeView).inset(7)
            make.centerY.equalTo(cookTimeView)
        }
        
        cookTimeView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(recipeImageView).inset(8)
            make.height.equalTo(25)
            make.leading.equalTo(cookTimeLabel).offset(-7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authorImageView.snp.top).offset(-12)
            make.trailing.leading.equalToSuperview()
        }
        
        authorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.bottom.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(authorImageView)
            make.leading.equalTo(authorImageView.snp.trailing).offset(7)
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
    
    @objc private func favButtonTapped(_ sender: UIButton) {
        onFavTap?()
    }
    
}
