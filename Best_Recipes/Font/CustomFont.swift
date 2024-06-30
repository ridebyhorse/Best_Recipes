//
//  CustomFont.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 30.06.2024.
//

import UIKit

enum CustomFont: String {
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
}

extension UIFont {
    ///Пример использования: label.font = .custom(font: .bold, size: 22)
    static func custom(font: CustomFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
          fatalError(
            "Failed to load the \(font.rawValue) font."
          )
        }
        return customFont
      }
}
