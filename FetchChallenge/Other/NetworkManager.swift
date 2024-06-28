//
//  NetworkManager.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    static let baseURL = "https://themealdb.com/api/json/v1/1/filter.php?c="
    private let dessertURL = baseURL + "Dessert"
    
    func getMenuItems() async throws -> [MenuItem] {
        
        guard let checkedURL = URL(string: dessertURL) else {
            throw FCError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: checkedURL)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MenuResponse.self, from: data).meals
            
        } catch {
            throw FCError.invalidData
        }
    }
    
    private init() {}
}
