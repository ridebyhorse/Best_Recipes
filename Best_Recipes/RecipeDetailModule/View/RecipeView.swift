//
//  RecipeView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RecipeView: UIView {
    
    private var onFavTap: (() -> Void)?
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .custom(font: .bold, size: 24)
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let ratingView = RatingView()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreyApp
        label.font = .custom(font: .regular, size: 14)
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(
        image: URL?,
        title: String,
        steps: [String],
        rating: String,
        reviewsCount: String,
        isFavorite: Bool,
        onFavTap: (() -> Void)?
    ) {
        titleLabel.text = title
        setList(of: steps)
        ratingView.configureView(with: rating)
        reviewsLabel.text = "(\(reviewsCount) Reviews)"
        imageView.update(with: .init(url: image, cornerRadius: 15))
        
        let buttonImageName = isFavorite ? "fav" : "fav_disabled"
        bookmarkButton.setImage(UIImage(imageLiteralResourceName: buttonImageName), for: .normal)
        self.onFavTap = onFavTap
    }
    
    @objc private func bookmarkButtonTapped() {
        onFavTap?()
    }
    
    private func setList(of items: [String]) {
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
        contentView.addSubview(bookmarkButton)
        
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
        
        titleLabel.snp.makeConstraints { $0.top.equalToSuperview().inset(16) }
        titleLabel.snp.makeConstraints { $0.leading.trailing.equalToSuperview().inset(19) }
        
        imageView.snp.makeConstraints { $0.top.equalTo(titleLabel.snp.bottom).offset(20) }
        imageView.snp.makeConstraints { $0.leading.trailing.equalToSuperview().inset(19) }
        imageView.snp.makeConstraints { $0.height.equalTo(200) }
        
        ratingStack.snp.makeConstraints { $0.top.equalTo(imageView.snp.bottom).offset(20) }
        ratingStack.snp.makeConstraints { $0.leading.trailing.equalToSuperview().inset(19) }
        
        bookmarkButton.snp.makeConstraints {
            $0.height.width.equalTo(32)
            $0.top.equalTo(imageView.snp.top).inset(8)
            $0.trailing.equalTo(imageView.snp.trailing).inset(8)
        }
        
        instructionsLabel.snp.makeConstraints { $0.top.equalTo(ratingStack.snp.bottom).offset(13) }
        instructionsLabel.snp.makeConstraints { $0.leading.equalToSuperview().inset(19) }
        
        instructionsStack.snp.makeConstraints { $0.top.equalTo(instructionsLabel.snp.bottom).offset(8) }
        instructionsStack.snp.makeConstraints { $0.trailing.leading.equalToSuperview().inset(19) }
        
        ingredientsTableView.snp.makeConstraints { $0.top.equalTo(instructionsStack.snp.bottom).offset(16) }
        ingredientsTableView.snp.makeConstraints { $0.trailing.bottom.leading.equalToSuperview().inset(19) }
    }
}
