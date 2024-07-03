//
//  Dessert.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 7/2/24.
//

import Foundation

//struct Dessert: Hashable, Codable {
//    let mealName: String
//    let cuisine: String
//    
//    let instructions: String
//    let ingredients: [String]
//    let measurements: [String]
//}

struct Dessert: Hashable, Codable {
    let strMeal: String // mealName
    let strArea: String // cuisine
    
    let strInstructions: String // instructions
    
//    let ingredients: [String]
//    let measurements: [String]
    
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strIngredient7: String
    let strIngredient8: String
    let strIngredient9: String
    let strIngredient10: String
    let strIngredient11: String
    let strIngredient12: String
    let strIngredient13: String
    let strIngredient14: String
    let strIngredient15: String
    let strIngredient16: String
    let strIngredient17: String
    let strIngredient18: String
    let strIngredient19: String
    let strIngredient20: String
}

struct DessertResponse: Codable {
    let meals: [Dessert]
}
