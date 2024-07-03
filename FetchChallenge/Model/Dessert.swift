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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(mealName, forKey: .mealName)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encode(instructions, forKey: .instructions)
        
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKeys.self)
        
        for (index, ingredient) in ingredients.enumerated() {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index + 1)") {
                try dynamicContainer.encode(ingredient, forKey: ingredientKey)
            }
        }
        
        for (index, measurement) in measurements.enumerated() {
            if let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(index + 1)") {
                try dynamicContainer.encode(measurement, forKey: measurementKey)
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mealName = try container.decode(String.self, forKey: .mealName)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredientsArray: [String?] = []
        var measurementsArray: [String?] = []
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for i in 1...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
               let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(i)") {
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
