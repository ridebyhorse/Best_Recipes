//
//  DIContainer.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 02.07.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    var networkManager: NetworkManager { get }
}

protocol StorageServiceProtocol {
    var storageService: StorageService { get }
}

/**Контейнер зависимостей
 
 Использование:
 
 в Presenter создаем typealias с протоколами нужных сервисов, например:
 - typealias Services = NetworkManagerProtocol & StorageServiceProtocol
 - let networkManager: NetworkManager
 - let storageService: StorageService
 
 Или если нужен, например, только сетевой сервис
 - typealias Services = NetworkManagerProtocol
 - let networkManager: NetworkManager
 
 Далее в инициализации Presenterа инжектим typealias:
 - init(container: Services) { self.networkManager = container.networkManager }
 */
final class DIContainer: NetworkManagerProtocol, StorageServiceProtocol {
    
    static let shared = DIContainer()
    
    let networkManager: NetworkManager
    let storageService: StorageService
    
    private init() {
        self.networkManager = NetworkManager(networkService: NetworkService.shared)
        self.storageService = StorageService.shared
    }
}
