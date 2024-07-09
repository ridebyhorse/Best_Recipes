//
//  BannerRecipesView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 2.07.24.
//

import UIKit
import SnapKit
final class BannerRecipesView: CellView, Configurable {
    let precipeImageView = UIImageView()
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
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: CustomTabBarController())
}

final class TitleRecipesView: CellView, Configurable {
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private let stackView = UIStackView()
    private var seeAllHandler: (() -> Void)?
    
    func update(with model: SeeAll?) {
        guard let model = model else {
            stackView.removeFromSuperview()
            label.text = nil
            seeAllHandler = nil
            button.isHidden = true
            return
        }
        
        label.text = model.headerName
        
    }
    
    override func configure() {
        addSubviews(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.setTitle("See All", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .custom(font: .bold, size: 20)
        button.titleLabel?.textColor = .white
        label.font = .custom(font: .bold, size: 24)
        stackView.addArrangedSubviews(label, button)
        stackView.axis = .horizontal
    }
}

final class TimeCircleRecipesView: CellView, Configurable {
    private let precipeImageView = UIImageView()
    private let backgroundView = UIView()
    private let nameRecipeLabel = UILabel()
    private let cookingTimeLabel = UILabel()
    private let cookingTimeTitleLabel = UILabel()
    
    
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            //precipeImageView.layer.cornerRadius = precipeImageView.frame.height / 2
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: precipeImageView.frame.height / 2))
        nameRecipeLabel.text = model.recipeName
        nameRecipeLabel.numberOfLines = 2
        nameRecipeLabel.font = .custom(font: .bold, size: 14)
        nameRecipeLabel.textAlignment = .center
        
        
    }
    
    override func configure() {
        setupSubView()
        setupContraints()
        
        backgroundView.backgroundColor = .lightGreyApp
        backgroundView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        precipeImageView.layer.cornerRadius = precipeImageView.frame.height / 2
        precipeImageView.clipsToBounds = true
        
    }
}

private extension TimeCircleRecipesView {
    func setupSubView() {
        addSubviews(backgroundView, precipeImageView, nameRecipeLabel)
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
            make.top.equalTo(precipeImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
}


final class CategoryView: CellView {
    
    private let categoryLabel = UILabel()
    
    override func configure() {
        addSubview(categoryLabel)
        categoryLabel.font = .custom(font: .bold, size: 12)
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        
        layer.cornerRadius = 10
        
    }
  
    override func cellSelected(_ isSelected: Bool) {
        print(isSelected)
        backgroundColor = isSelected ? .redApp : .white
        categoryLabel.textColor = isSelected ? .white : .redCategoryText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(frame)
    }
}


extension CategoryView: Configurable {
    func update(with model: Category?) {
        guard let model = model else {
            return
        }
        categoryLabel.text = model.headerName
        print(frame)
    }
}
