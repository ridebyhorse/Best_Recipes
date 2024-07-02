//
//  DIContainer.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 02.07.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    var networkService: NetworkService { get }
}

protocol StorageServiceProtocol {
    var storageService: StorageService { get }
}

/**Контейнер зависимостей
 
 Использование:
 
 в Presenter создаем typealias с протоколами нужных сервисов, например:
 - typealias Services = NetworkServiceProtocol & StorageServiceProtocol
 - let networkService: NetworkService
 - let storageService: NetworkService
 
 Или если нужен, например, только сетевой сервис
 - typealias Services = NetworkServiceProtocol
 - let networkService: NetworkService
 
 Далее в инициализации Presenterа инжектим typealias:
 - init(container: Services) { self.networkService = container.networkService }
 */
final class DIContainer: NetworkServiceProtocol, StorageServiceProtocol {
    
    static let shared = DIContainer()
    
    let networkService: NetworkService
    let storageService: StorageService
    
    private init() {
        self.networkService = NetworkService.shared
        self.storageService = StorageService.shared
    }
}
