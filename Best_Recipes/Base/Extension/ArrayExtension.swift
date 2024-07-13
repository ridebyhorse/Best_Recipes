//
//  ArrayExtension.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 13.07.2024.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
