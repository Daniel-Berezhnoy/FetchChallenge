//
//  MealView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI
import CachedAsyncImage

struct MealView: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            image
            
            VStack(alignment: .leading, spacing: 8) {
                title
                id
            }
            .padding(.leading)
        }
        .padding(.vertical, 5)
    }
    
    private var id: some View {
        Text(meal.id)
            .foregroundColor(.secondary)
    }
    
    private var image: some View {
        CachedAsyncImage(url: URL(string: meal.imageURL)) { image in
            image.resizable()
        } placeholder: {
            Image(.mealPlaceholder)
                .resizable()
                .scaleEffect(1.3)
        }
        .scaledToFill()
        .frame(width: 120, height: 90)
        .cornerRadius(8)
    }
    
    private var title: some View {
        Text(meal.title)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    init(for meal: Meal) {
        self.meal = meal
    }
}

#Preview {
    MealView(for: Meal.sampleItem)
}
