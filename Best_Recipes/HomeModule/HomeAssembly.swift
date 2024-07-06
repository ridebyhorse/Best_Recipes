//
//  HomeAssembly.swift
//  Best_Recipes
//
//  Created by Станислав Артамонов on 3.07.24.
//

import Foundation
import UIKit
class HomeAssembly {
    
    func build(coordinator: HomeCoordinator) -> UIViewController {
        let view = HomeControllerImpl()
        let presenter  = HomePresenterImpl(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
}
