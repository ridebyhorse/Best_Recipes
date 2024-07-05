//
//  UnsafeTask.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 04.07.2024.
//

import Foundation

class UnsafeTask<T> {
    
    let semaphore = DispatchSemaphore(value: 0)
    private var result: T?
    
    init(block: @escaping () async -> T) {
        Task {
            result = await block()
            semaphore.signal()
        }
    }

    func get() -> T {
        if let result = result { return result }
        semaphore.wait()
        return result!
    }
}
