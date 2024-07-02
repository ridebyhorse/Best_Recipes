//
//  IngridientView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

class IngridientView: UIView {

    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "200g"
        label.textColor = .darkGreyApp
        label.font = .custom(font: .regular, size: 14)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(buttonAction),
            for: .touchUpInside
        )
        return button
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 24
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .greyApp
        layer.cornerRadius = 15
        
        imageView.image = UIImage(named: "Ingredients")
        titleLabel.text = "Fish"
        descriptionLabel.text = "200g"
        button.setImage(UIImage(named: "Checkbox"), for: .normal)
    }
    
    private func addSubviews() {
        addSubview(contentStack)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(button)
    }
    
    private func setConstraints() {
        contentStack.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
        imageView.snp.makeConstraints { $0.width.equalTo(imageView.snp.height) }
        button.snp.makeConstraints { $0.width.height.equalTo(23) }
    }
    
    
    @objc private func buttonAction() {
        
    }
}
