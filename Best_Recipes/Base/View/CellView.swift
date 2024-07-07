//
//  CellView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 7.07.24.
//

import UIKit

class CellView: UIView {
    var isSelected: Bool {
        didSet {
            
        }
    }
    init() {
        self.isSelected = false
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
