//
//  RatingView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

final class RatingView: UIView {
    
    private let starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Star")
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with rating: String) {
        ratingLabel.text = rating
    }
    
    private func addSubview() {
        addSubview(starImage)
        addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        starImage.snp.makeConstraints { $0.width.height.equalTo(16) }
        starImage.snp.makeConstraints { $0.top.leading.bottom.equalToSuperview() }
        
        ratingLabel.snp.makeConstraints { $0.top.trailing.bottom.equalToSuperview() }
        ratingLabel.snp.makeConstraints { $0.leading.equalTo(starImage.snp.trailing).inset(-5) }
    }
}
