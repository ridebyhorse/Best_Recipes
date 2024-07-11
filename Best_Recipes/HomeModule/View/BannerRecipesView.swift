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

final class TitleRecipesView: CellView, Configurable {
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private let stackView = UIStackView()
    private var seeAllHandler: (() -> Void)?
    
    func update(with model: SeeAll?) {
        guard let model = model else {
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
    private let timeStackView = UIStackView()
    private let favoriteButton = createButton()
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            nameRecipeLabel.text = nil
            cookingTimeTitleLabel.text = nil
            cookingTimeLabel.text = nil
            favoriteButton.setImage(.bookmark, for: .normal)
            return
        }
        
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: precipeImageView.frame.height / 2))
        nameRecipeLabel.text = model.recipeName
        
        cookingTimeLabel.text = String(model.coockingTime) + " Mins"
        cookingTimeTitleLabel.text = "Time"
        nameRecipeLabel.numberOfLines = 2
        nameRecipeLabel.font = .custom(font: .bold, size: 14)
        nameRecipeLabel.textAlignment = .center
       
        
        cookingTimeTitleLabel.font = .custom(font: .regular, size: 12)
        cookingTimeTitleLabel.textColor = .darkGreyApp
        cookingTimeLabel.font = .custom(font: .bold, size: 12)
        
        let imageButton: UIImage = !model.isFavorite ? .bookmarkActive : .bookmark
        favoriteButton.setImage(imageButton, for: .normal)
        
        
    }
    
    override func configure() {
        setupSubView()
        setupContraints()
        setupStackView()
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
        addSubviews(backgroundView, precipeImageView, nameRecipeLabel, timeStackView, favoriteButton)
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
    
    func setupStackView() {
        timeStackView.addArrangedSubviews(cookingTimeTitleLabel, cookingTimeLabel)
        timeStackView.axis = .vertical
        timeStackView.spacing = 5
        timeStackView.distribution = .fillEqually
    }
    
    static func createButton() -> UIButton {
        let button = UIButton()
        button.tag = 0
        button.setImage(.bookmark, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
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
        backgroundColor = isSelected ? .redApp : .white
        categoryLabel.textColor = isSelected ? .white : .redCategoryText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}


extension CategoryView: Configurable {
    func update(with model: Category?) {
        guard let model = model else {
            return
        }
        categoryLabel.text = model.headerName
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ModuleFactory().createHomeModule(flowHandler: nil))
}



final class RecentRecipeView: CellView {
    private let precipeImageView = UIImageView()
    private let nameRecipeLabel = UILabel()
    private let avtorNameLabel = UILabel()
    
    override func configure() {
        setupSubView()
        setupContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

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

extension RecentRecipeView: Configurable {
    
    func update(with model: RecipesCellViewModel?) {
        guard let model = model else {
            precipeImageView.update(with: nil)
            avtorNameLabel.text = nil
            avtorNameLabel.text = nil
            return
        }
        print(frame)
        precipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: 10))
        nameRecipeLabel.text = model.recipeName
        avtorNameLabel.text = model.avtorName
       
       
        nameRecipeLabel.font = .custom(font: .bold, size: 14)
        nameRecipeLabel.textAlignment = .left
        nameRecipeLabel.numberOfLines = 2
        
        avtorNameLabel.font = .custom(font: .regular, size: 12)
        avtorNameLabel.textColor = .darkGreyApp
        avtorNameLabel.font = .custom(font: .bold, size: 12)
        
        
    }
}


final class CountryCategoryView: CellView {
    private let countryImageView = UIImageView()
    private let countryNameLabel = UILabel()
 
    
    override func configure() {
        setupSubView()
        setupContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        countryImageView.layer.cornerRadius = countryImageView.frame.height / 2
        countryImageView.clipsToBounds = true
        print(frame)
    }
}

private extension CountryCategoryView {
    
    func setupSubView() {
        addSubviews(countryImageView, countryNameLabel)
    }
    
    func setupContraints() {
        countryImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(100)
            make.width.height.equalTo(self.snp.width)
        }
        
        countryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(countryImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(15)
            
        }
    }
}

extension CountryCategoryView: Configurable {
    
    func update(with model: Country?) {
        guard let model = model else {
            countryImageView.update(with: nil)
            countryNameLabel.text = nil
            return
        }

        countryImageView.update(with: .init(image: UIImage(named: model.imageName), cornerRadius:  countryImageView.frame.height / 2))
        countryNameLabel.text = model.name
        
       
       
        countryNameLabel.font = .custom(font: .bold, size: 14)
        countryNameLabel.textAlignment = .center
        
    }
}
