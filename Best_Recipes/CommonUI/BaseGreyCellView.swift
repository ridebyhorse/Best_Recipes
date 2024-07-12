//
//  BaseGreyCellView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit

class BaseGreyCellView: UIView {
    
    private var buttonAction: (() -> Void)?
    
    private let imageView = UIImageView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreyApp
        label.font = .custom(font: .regular, size: 14)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(buttonTapped),
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
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(
        image: URL,
        title: String,
        description: String,
        buttonImage: UIImage?,
        buttonColor: UIColor,
        buttonAction: @escaping () -> Void
    ) {
        backgroundColor = .greyApp
        layer.cornerRadius = 15
        imageView.backgroundColor = .white
        imageView.update(with: .init(url: image,contenMode: .scaleAspectFit, cornerRadius: 8))
        titleLabel.text = title
        descriptionLabel.text = description
        
        configureButton(
            image: buttonImage,
            color: buttonColor,
            action: buttonAction
        )
    }
    
    func configureButton(
        image: UIImage? = nil,
        color: UIColor? = nil,
        action: (() -> Void)? = nil
    ) {
        if let image = image {
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        if let color = color {
            button.tintColor = color
        }
        
        if let action = action {
            self.buttonAction = action
        }
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
        button.snp.makeConstraints { $0.width.equalTo(23) }
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
