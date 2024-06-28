//
//  Meal.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

struct Meal: Hashable, Codable {
    let idMeal: String // id
    let strMeal: String // title
    let strMealThumb: String // imageURL
}

struct MenuResponse: Codable {
    let meals: [Meal]
}

extension Meal {
    static let sampleItem = Meal(idMeal: "1234", strMeal: "Title", strMealThumb: "https://picsum.photos/200")
}
