//
//  CategoryView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 11.07.24.
//

import UIKit
import SnapKit

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
