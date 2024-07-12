//
//  CountryView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 11.07.24.
//

import UIKit
import SnapKit

//MARK: - CountryCategoryView
final class CountryCategoryView: CellView {
    private let countryImageView = UIImageView()
    private let countryNameLabel = createcountryNameLabel()
 
    
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

//MARK: - Configgurable impl
extension CountryCategoryView: Configurable {
    
    func update(with model: Country?) {
        guard let model = model else {
            countryImageView.update(with: nil)
            countryNameLabel.text = nil
            return
        }
        
        countryImageView.update(with: .init(image: UIImage(named: model.imageName), cornerRadius:  countryImageView.frame.height / 2))
        countryNameLabel.text = model.name
    }
}

//MARK: - Private method
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

//MARK: - Crete and Configure View
private extension CountryCategoryView {
    
    static func createcountryNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 14)
        label.textAlignment = .center
        return label
    }
}
