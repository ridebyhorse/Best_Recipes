//
//  KeyConstant.swift
//  Best_Recipes
//
//  Created by Мария Нестерова on 04.07.2024.
//

import Foundation

enum KeyConstant {
    static func loadAPIKeys() async throws {
        let request = NSBundleResourceRequest(tags: ["APIKey"])
        try await request.beginAccessingResources()
        
        let url = Bundle.main.url(forResource: "APIKey", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        APIKey.storage = try JSONDecoder().decode([String: String].self, from: data)
        
        request.endAccessingResources()
    }
    
    enum APIKey {
        static fileprivate(set) var storage = [String: String]()
        
        static var apiKey1: String { storage["apiKey1"] ?? "" }
        static var apiKey2: String { storage["apiKey2"] ?? "" }
    }
}
