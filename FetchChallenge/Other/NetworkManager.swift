//
//  NetworkManager.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    static let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    private let dessertURL = baseURL + "filter.php?c=Dessert"
    private let lookupURL = baseURL + "lookup.php?i="
    
    // Fetches the menu items and returns an array of Meals objects
    func getMenuItems() async throws -> [Meal] {
        
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
    
    // Finds a dessert by its ID, fetches its details, and returns a Dessert object
    func findDessert(withID dessertID: String) async throws -> Dessert {
        
        guard let checkedURL = URL(string: lookupURL + dessertID) else {
            throw FCError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: checkedURL)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(DessertResponse.self, from: data).meals.first!
            
        } catch {
            throw FCError.invalidData
        }
    }
    
    private init() {}
}
