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
}

struct MenuResponse: Codable {
    let meals: [Meal]
}

extension Meal {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case imageURL = "strMealThumb"
    }
}

extension Meal {
    static let sample = Meal(id: "52768", title: "Apple Frangipan Tart", imageURL: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
    static let fallbackYTLink = "https://www.youtube.com/watch?v=mhDJNfV7hjk"
}
