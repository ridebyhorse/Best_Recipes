//
//  Configurable.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 1.07.24.
//

import UIKit

protocol Configurable: AnyObject {
    associatedtype Model
    
    func update(with model: Model?)
}
