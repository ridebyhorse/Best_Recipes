//
//  SeeAllCountryView.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import UIKit
import SnapKit

final class SeeAllCountryView: CellView {
    
    private let countryLabel = UILabel()
    
    override func configure() {
        addSubview(countryLabel)
        countryLabel.font = .custom(font: .bold, size: 12)
        countryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        layer.cornerRadius = 10
    }
  
    override func cellSelected(_ isSelected: Bool) {
        backgroundColor = isSelected ? .redApp : .white
        countryLabel.textColor = isSelected ? .white : .redApp
    }
}

extension SeeAllCountryView: Configurable {
    func update(with model: SeeAllCountry?) {
        guard let model = model else {
            return
        }
        countryLabel.text = model.headerName
    }
}
