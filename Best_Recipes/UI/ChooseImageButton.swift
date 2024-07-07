//
//  CreateImageButton.swift
//  Best_Recipes
//
//  Created by Сергей Сухарев on 06.07.2024.
//

import UIKit

class ChooseImageButton: UIButton {
    
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
        tintColor = .black
        setBackgroundImage(UIImage(named: "Edit"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTappedAdd), for: .touchUpInside)
    }
    
   @objc internal func buttonTappedAdd() {
       print("tap")
    }
}
