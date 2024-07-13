//
//  FlowProtocol.swift
//  Best_Recipes
//
//  Created by Natalia on 07.07.2024.
//

protocol FlowProtocol {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
