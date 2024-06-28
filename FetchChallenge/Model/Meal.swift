//
//  Meal.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

struct Meal: Hashable, Codable {
    let id: String
    let title: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case imageURL = "strMealThumb"
    }
}

struct MenuResponse: Codable {
    let meals: [Meal]
}

extension Meal {
    static let sampleItem = Meal(id: "1234", title: "Title", imageURL: "https://picsum.photos/200")
}
