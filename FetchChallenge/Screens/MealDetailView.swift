//
//  MealDetailView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    
    var body: some View {
        ScrollView {
            Text(meal.id)
        }
        .navigationTitle(meal.title.capitalized)
    }
    
    init(for meal: Meal) {
        self.meal = meal
    }
}

#Preview {
    MealDetailView(for: Meal.sampleItem)
}
