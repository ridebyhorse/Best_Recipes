//
//  RecipeView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit
import SnapKit

final class RecipeView: UIView {
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How to make Tasty Fish (point & Kill)"
        label.numberOfLines = .zero
        label.font = .custom(font: .bold, size: 24)
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Onboarding1")
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let ratingView = RatingView()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.text = "(300 Reviews)"
        label.textColor = .darkGreyApp
        label.font = .custom(font: .regular, size: 14)
        return label
    }()
    
    private let ratingStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 7
        stack.alignment = .leading
        return stack
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = .custom(font: .bold, size: 20)
        return label
    }()
    
    private let instructionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private(set) var ingredientsTableView = IngredientsTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
        backgroundColor = .white
        
        #warning("remove this")
        setList(of: [
        "Place eggs in a saucepan and cover with cold water.", "Bring water to a boil and immediately remove from heat.", "Cover and let eggs stand in hot water for 10 to 12 minutes.", "Remove from hot water, cool, peel, and chop.", "Place chopped eggs in a bowl.", "Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice.", "Stir in mayonnaise, green onion, and mustard.", "Season with paprika, salt, and pepper.", "Stir and serve on your favorite bread or crackers."
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setList(of items: [String]) {
        for (number, text) in items.enumerated() {
            let numberedItem = NumberedView(number: "\(number + 1)", text: text)
            instructionsStack.addArrangedSubview(numberedItem)
        }
    }
    
    private func addSubviews() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(ratingStack)
        
        ratingStack.addArrangedSubview(ratingView)
        ratingStack.addArrangedSubview(reviewsLabel)
        ratingStack.addArrangedSubview(UIView())
        
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(instructionsStack)
        contentView.addSubview(ingredientsTableView)
    }
    
    private func makeConstraints() {
        
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints { $0.edges.width.equalToSuperview() }
        
        titleLabel.snp.makeConstraints { $0.top.equalToSuperview().offset(16) }
        titleLabel.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }
        titleLabel.snp.makeConstraints { $0.trailing.equalToSuperview().offset(-19) }
        
        imageView.snp.makeConstraints { $0.top.equalTo(titleLabel.snp.bottom).offset(20) }
        imageView.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }
        imageView.snp.makeConstraints { $0.trailing.equalToSuperview().offset(-19) }
        imageView.snp.makeConstraints { $0.height.equalTo(200) }
        
        ratingStack.snp.makeConstraints { $0.top.equalTo(imageView.snp.bottom).offset(20) }
        ratingStack.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }
        ratingStack.snp.makeConstraints { $0.trailing.equalToSuperview().offset(-19) }
        
        instructionsLabel.snp.makeConstraints { $0.top.equalTo(ratingStack.snp.bottom).offset(16) }
        instructionsLabel.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }
        
        instructionsStack.snp.makeConstraints { $0.top.equalTo(instructionsLabel.snp.bottom).offset(16) }
        instructionsStack.snp.makeConstraints { $0.trailing.equalToSuperview().offset(-19) }
        instructionsStack.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }

        ingredientsTableView.snp.makeConstraints { $0.top.equalTo(instructionsStack.snp.bottom).offset(16) }
        ingredientsTableView.snp.makeConstraints { $0.trailing.bottom.equalToSuperview().offset(-19) }
        ingredientsTableView.snp.makeConstraints { $0.leading.equalToSuperview().offset(19) }
    }
}
