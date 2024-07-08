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

final class TitleRecipesView: CustomView, Configurable {
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

final class TimeCircleRecipesView: CustomView, Configurable {
    let precipeImageView = UIImageView()
    private let nameRecipeLabel = UILabel()
    
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            //precipeImageView.layer.cornerRadius = precipeImageView.frame.height / 2
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: precipeImageView.frame.height / 2))
        
        backgroundColor = .systemGray
        
    }
    
    override func configure() {
        addSubviews(precipeImageView, nameRecipeLabel)
        
        
        
        
        precipeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameRecipeLabel.snp.makeConstraints { make in
            make.top.equalTo(precipeImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
        //  precipeImageView.update(with: .init( cornerRadius: precipeImageView.frame.height / 2 ))
        // precipeImageView.clipsToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        precipeImageView.layer.cornerRadius = precipeImageView.frame.height / 2
        precipeImageView.clipsToBounds = true
    }
    
}


final class CategoryView: CustomView, Configurable {
    
    private let categoryLabel = UILabel()
    
    
    func update(with model: Category?) {
        guard let model = model else {
            
            return
        }
        
        categoryLabel.text = model.headerName
        
        
        
    }
    
    override func configure() {
        addSubview(categoryLabel)
        categoryLabel.font = .custom(font: .bold, size: 13)
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
    }
    
}
