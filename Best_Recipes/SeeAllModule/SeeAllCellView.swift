import UIKit
import SnapKit

final class SeeAllCellView: CellView {
    private let recipeImageView = UIImageView()
    private let recipeNameLabel = createNameRecipeLabel()
    private let creatorNameLabel = createCreatorNameLabel()
    private lazy var favoriteButton = createButton()
    private var favoriteHandler: (() -> Void)?
    
    override func configure() {
        setupSubView()
        setupContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recipeImageView.layer.cornerRadius = recipeImageView.frame.height / 2
        recipeImageView.clipsToBounds = true
    }
    
}

//MARK: - Configgurable impl
extension SeeAllCellView: Configurable {
    func update(with model: RecipesCellViewModel?) {
        
        guard let model = model else {
            recipeImageView.update(with: nil)
            recipeNameLabel.text = nil
            creatorNameLabel.text = nil
            favoriteButton.setImage(.bookmark, for: .normal)
            favoriteHandler = nil
            return
        }
        
        recipeImageView.update(with: .init(url: model.recipeImage , cornerRadius: recipeImageView.frame.height / 2))
        recipeNameLabel.text = model.recipeName
        creatorNameLabel.text = model.avtorName
        favoriteHandler = model.favoriteHandler
        let imageButton: UIImage = model.isFavorite ? .bookmarkActive : .bookmark
        favoriteButton.setImage(imageButton, for: .normal)
    }
}


private extension SeeAllCellView{
    
    func setupSubView() {
        addSubviews(recipeImageView, recipeNameLabel,creatorNameLabel, favoriteButton)
    }
    
    func setupContraints(){
        recipeImageView.snp.makeConstraints{
            make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(self.snp.width).multipliedBy(0.78)
        }
        recipeNameLabel.snp.makeConstraints {
            make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        creatorNameLabel.snp.makeConstraints{
            make in
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
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

private extension SeeAllCellView {
    
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
        label.font = .custom(font: .bold, size: 16)
        label.textAlignment = .center
        return label
    }
    static func createCreatorNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 12)
        label.textAlignment = .left
        return label
    }
}
