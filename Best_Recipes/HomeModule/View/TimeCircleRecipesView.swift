//
//  TimeCircleRecipesView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 11.07.24.
//

import UIKit
import SnapKit

//MARK: - TimeCircleRecipesView
final class TimeCircleRecipesView: CellView {
    private let precipeImageView = UIImageView()
    private let backgroundView = createBackgroundView()
    private let nameRecipeLabel = createNameRecipeLabel()
    private let cookingTimeLabel = createCookingTimeLabel()
    private let cookingTimeTitleLabel = createCookingTimeTitleLabel()
    private let timeStackView = createStackView()
    private lazy var favoriteButton = createButton()
    private var favoriteHandler: (() -> Void)?
    
    override func configure() {
        setupSubView()
        setupContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        precipeImageView.layer.cornerRadius = precipeImageView.frame.height / 2
        precipeImageView.clipsToBounds = true
    }
}

//MARK: - Configgurable impl
extension TimeCircleRecipesView: Configurable {
    func update(with model: RecipesCellViewModel?) {
        
        guard let model = model else {
            precipeImageView.update(with: nil)
            nameRecipeLabel.text = nil
            cookingTimeTitleLabel.text = nil
            cookingTimeLabel.text = nil
            favoriteButton.setImage(.bookmark, for: .normal)
            favoriteHandler = nil
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: precipeImageView.frame.height / 2))
        nameRecipeLabel.text = model.recipeName
        cookingTimeLabel.text = String(model.coockingTime) + " Mins"
        cookingTimeTitleLabel.text = "Time"
        favoriteHandler = model.favoriteHandler
        let imageButton: UIImage = model.isFavorite ? .bookmarkActive : .bookmark
        favoriteButton.setImage(imageButton, for: .normal)
    }
}

//MARK: - Private method
private extension TimeCircleRecipesView {
    func setupSubView() {
        addSubviews(backgroundView, precipeImageView, nameRecipeLabel, timeStackView, favoriteButton)
        timeStackView.addArrangedSubviews(cookingTimeTitleLabel, cookingTimeLabel)
    }
    
    func setupContraints() {
        precipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(self.snp.width).multipliedBy(0.78)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(precipeImageView.snp.centerY)
        }
        
        nameRecipeLabel.snp.makeConstraints { make in
            make.top.equalTo(precipeImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        timeStackView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(11)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc
    func tappedFavorite() {
        favoriteHandler?()
    }
}

//MARK: - Crete and Configure View
private extension TimeCircleRecipesView {
    
    static func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createButton() -> UIButton {
        let button = UIButton()
        button.tag = 0
        button.setImage(.bookmark, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tappedFavorite), for: .touchUpInside)
        return button
    }
    
    static func createNameRecipeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .custom(font: .bold, size: 14)
        label.textAlignment = .center
        return label
    }
    
    static func createCookingTimeLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 12)
        label.textAlignment = .left
        return label
    }
    
    static func createCookingTimeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 12)
        label.textColor = .darkGreyApp
        label.textAlignment = .left
        return label
    }
    
    static func createBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGreyApp
        view.layer.cornerRadius = 10
        return view
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ModuleFactory().createHomeModule(flowHandler: nil))
}
