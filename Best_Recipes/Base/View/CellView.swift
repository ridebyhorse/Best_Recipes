//
//  CellView.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 7.07.24.
//

import UIKit

class CellView: CustomView {
    var isSelected: Bool {
        didSet {
            cellSelected(isSelected)
        }
    }
    override init(frame: CGRect) {
        self.isSelected = false
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSelected(_ isSelected: Bool) {
        
    }
}
