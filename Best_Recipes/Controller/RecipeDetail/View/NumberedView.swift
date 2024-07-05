//
//  NumberedView.swift
//  Best_Recipes
//
//  Created by Natalia on 01.07.2024.
//

import UIKit
import SnapKit

final class NumberedView: UIView {
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .custom(font: .regular, size: 16)
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .custom(font: .regular, size: 16)
        return label
    }()
    
    init(number: String, text: String) {
        super.init(frame: .zero)
        
        configureView(with: number, and: text)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(numberLabel)
        addSubview(textLabel)
    }
    
    private func makeConstraints() {
        numberLabel.snp.makeConstraints { $0.leading.top.equalToSuperview() }
        numberLabel.snp.makeConstraints { $0.width.equalTo(16) }
        
        textLabel.snp.makeConstraints { $0.trailing.top.bottom.equalToSuperview() }
        textLabel.snp.makeConstraints { $0.leading.equalTo(numberLabel.snp.trailing).offset(8) }
    }
    
    private func configureView(with number: String, and text: String) {
        numberLabel.text = "\(number)."
        textLabel.text = text
    }
}
