//
//  Dessert.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 7/2/24.
//

import Foundation

struct Dessert: Hashable, Codable {
    let mealName: String
    let cuisine: String
    
    let instructions: String
    let ingredients: [String?]
    let measurements: [String?]
}

extension Dessert {
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case cuisine = "strArea"
        case instructions = "strInstructions"
    }
    
    struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Container for fixed keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.mealName = try container.decode(String.self, forKey: .mealName)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        // Initialize arrays
        var ingredientsArray: [String?] = []
        var measurementsArray: [String?] = []
        
        // Dynamic container for ingredients and measurements
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        // Loop through 1 to 20 to decode ingredients and measurements
        for i in 1...20 {
            if let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(i)"),
               let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)") {
                
                let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey)
                let measurement = try dynamicContainer.decodeIfPresent(String.self, forKey: measurementKey)
                
                ingredientsArray.append(ingredient)
                measurementsArray.append(measurement)
            }
        }
        
        self.ingredients = ingredientsArray
        self.measurements = measurementsArray
    }
}

struct DessertResponse: Codable {
    let meals: [Dessert]
}
