//
//  PlusButton.swift
//  Best_Recipes
//
//  Created by Сергей Сухарев on 01.07.2024.
//

import UIKit

final class PlusButton: UIButton {
    
    var onTap: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tintColor = .blue
        setBackgroundImage(UIImage(named: "CreateRecipe"), for: .normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0,
                                    height: 5)
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
   @objc func buttonTapped() {
       onTap?()
    }
}
