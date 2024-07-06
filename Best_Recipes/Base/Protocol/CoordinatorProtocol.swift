//
//  CoordinatorProtocol.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol CoordinatorProtocol: AnyObject {
    func start()
}
