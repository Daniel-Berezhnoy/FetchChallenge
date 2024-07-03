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
}

struct DessertResponse: Codable {
    let meals: [Dessert]
}
