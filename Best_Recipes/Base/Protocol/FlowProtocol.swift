//
//  FlowProtocol.swift
//  Best_Recipes
//
//  Created by Natalia on 07.07.2024.
//

protocol FlowProtocol {
    var flowHandler: (() -> Void)? { get set }
}
