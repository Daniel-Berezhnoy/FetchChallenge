//
//  MenuItem.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

struct MenuItem: Hashable, Codable {
    let idMeal: String // ID
    let strMeal: String // title
    let strMealThumb: String // imageURL
}

extension MenuItem {
    static let sampleItem = MenuItem(idMeal: "1234", strMeal: "Title", strMealThumb: "https://picsum.photos/200")
}
