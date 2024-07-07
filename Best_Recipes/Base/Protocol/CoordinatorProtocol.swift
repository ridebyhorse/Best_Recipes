//
//  CoordinatorProtocol.swift
//  Best_Recipes
//
//  Created by Natalia on 05.07.2024.
//

typealias CoordinatorHandler = () -> ()

protocol CoordinatorProtocol: AnyObject {
    var flowCompletionHandler: CoordinatorHandler? { get set }
    func start()
}
