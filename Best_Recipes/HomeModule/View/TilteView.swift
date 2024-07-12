//
//  TilteView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 11.07.24.
//

import UIKit
import SnapKit

//MARK: - TitleRecipesView
final class TitleRecipesView: CellView {
    private let headerLabel = createHeaderLabel()
    private lazy var button = createButton()
    
    private var seeAllHandler: (() -> Void)?
    
    
    override func configure() {
        addSubviews(headerLabel, button)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}

//MARK: - Configgurable impl
extension TitleRecipesView: Configurable {
    
    func update(with model: SeeAll?) {
        guard let model = model else {
            headerLabel.text = nil
            seeAllHandler = nil
            button.isHidden = false
            return
        }
        
        seeAllHandler = model.seeAllHandler
        headerLabel.text = model.headerName
        if model.seeAllHandler == nil {
            button.isHidden = true
        }
    }
}

//MARK: - Crete and Configure View
private extension TitleRecipesView {
    
    static func createHeaderLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 24)
        label.textAlignment = .center
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(.seeAll.withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.tintColor = .black
        button.titleLabel?.font = .custom(font: .bold, size: 20)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(tappedSeeAll), for: .touchUpInside)
        return button
    }
    
    static func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }
}

//MARK: - Private method
private extension TitleRecipesView {
    @objc
    func tappedSeeAll() {
        seeAllHandler?()
    }
}
