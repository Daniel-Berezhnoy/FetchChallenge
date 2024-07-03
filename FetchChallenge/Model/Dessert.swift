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

struct DessertResponse: Codable {
    let meals: [Dessert]
}

extension Dessert {
    var measuredIngredients: [(ingredient: String, measurement: String)] {
        var combined: [(String, String)] = []
        
        for (index, ingredient) in ingredients.enumerated() {
            if let ingredient = ingredient, !ingredient.isEmpty {
                
                let measurement = measurements.indices.contains(index) ? (measurements[index] ?? "") : ""
                combined.append((ingredient, measurement))
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

#warning("Remove if not needed")
//extension Dessert {
//    static let sample = Dessert(mealName: "Apple Frangipan Tart",
//                                cuisine: "British",
//                                instructions: sampleInstructions,
//                                ingredients: sampleIngredients,
//                                measurements: ["Test"])
//
//    private static let sampleInstructions = "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream."
//
//
//    private static let sampleIngredients = ["digestive biscuits", "butter", "Bramley apples", "butter, softened", "caster sugar", "free-range eggs, beaten", "ground almonds", "almond extract", "flaked almonds"]
//
//    private static let sampleMeasurements = ["Test"]
//}
