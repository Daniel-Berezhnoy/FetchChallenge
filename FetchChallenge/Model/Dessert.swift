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
    let ytLink: String
    
    let ingredients: [String?]
    let measurements: [String?]
}

struct DessertResponse: Codable {
    let meals: [Dessert]
}

extension Dessert {
    struct MeasuredIngredient: Hashable, Identifiable {
        let id = UUID()
        let ingredient: String
        let measurement: String
    }
    
    var measuredIngredients: [MeasuredIngredient] {
        var combined: [MeasuredIngredient] = []
        var seen: Set<MeasuredIngredient> = []
        
        for (index, ingredient) in ingredients.enumerated() {
            if let ingredient, !ingredient.isEmpty {
                
                let measurement = measurements.indices.contains(index) ? (measurements[index] ?? "") : ""
                let pair = MeasuredIngredient(ingredient: ingredient, measurement: measurement)
                
                if !seen.contains(pair) {
                    combined.append(pair)
                    seen.insert(pair)
                }
            }
        }
        
        return combined
    }
}

extension Dessert {
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case cuisine = "strArea"
        case instructions = "strInstructions"
        case ytLink = "strYoutube"
    }
}

extension Dessert {
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
}

extension Dessert {
    init(from decoder: Decoder) throws {
        
        // Container for fixed keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mealName = try container.decode(String.self, forKey: .mealName)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.ytLink = try container.decode(String.self, forKey: .ytLink)
        
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
