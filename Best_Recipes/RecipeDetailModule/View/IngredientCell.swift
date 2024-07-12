//
//  IngredientCell.swift
//  Best_Recipes
//
//  Created by Natalia on 02.07.2024.
//

import UIKit

final class IngredientCell: UITableViewCell {
    
    static let identifier = String(describing: IngredientCell.self)
    
    private var isChecked = false
    
    private let ingredientView = BaseGreyCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: IngredientCell.identifier)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(ingredintName: String, amount: String, image: URL) {
        ingredientView.configureView(
            image: image,
            title: ingredintName,
            description: amount,
            buttonImage: UIImage(named: "Checkbox"),
            buttonColor: .black,
            buttonAction: checkboxTapped)
    }
    
    private func checkboxTapped() {
#warning("save choice")
        isChecked.toggle()
        let buttonColor: UIColor = isChecked ? UIColor(resource: .redApp) : .black
        ingredientView.configureButton(color: buttonColor)
    }
    
    private func addSubviews() {
        contentView.addSubview(ingredientView)
    }
    
    private func setConstraints() {
        ingredientView.snp.makeConstraints { $0.leading.trailing.bottom.equalToSuperview() }
        ingredientView.snp.makeConstraints { $0.top.equalToSuperview().inset(13) }
        ingredientView.snp.makeConstraints { $0.height.equalTo(76) }
    }
}
