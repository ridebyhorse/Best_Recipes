//
//  Button.swift
//  CreateRecipe
//
//  Created by Сергей Сухарев on 05.07.2024.
//

import UIKit

final class CreateRecipeButton: UIButton {
    
    var onTap: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        config()
    }
    
    func config() {
        backgroundColor = UIColor(named: "redApp")
        setTitle("Create recipe", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.alpha = self.alpha == 1 ? 0.0 : 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.alpha = self.alpha == 1 ? 0.0 : 1
        }
        print("tap")
        onTap?()
    }
}
