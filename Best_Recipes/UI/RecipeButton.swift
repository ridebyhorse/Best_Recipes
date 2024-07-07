//
//  RecipeButton.swift
//  CreateRecipe
//
//  Created by Сергей Сухарев on 06.07.2024.
//

import UIKit

class RecipeButton: UIButton {

        var leftImage: UIImage?
        var rightImage: UIImage?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(named: "lightGreyApp")
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        if let leftImage = leftImage {
            let leftImageView = UIImageView(image: leftImage)
            leftImageView.contentMode = .scaleAspectFit
            addSubview(leftImageView)
            leftImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftImageView.widthAnchor.constraint(equalToConstant: 20),
                leftImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
            
        }
    }
    func setButtonTitle(title: String) {
         setTitle(title, for: .normal)
     }
   
}
