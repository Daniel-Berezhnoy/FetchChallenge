//
//  MealCellView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI
import CachedAsyncImage

struct MealCellView: View {
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
        .fontDesign(.rounded)
    }
    
    private var image: some View {
        CachedAsyncImage(url: URL(string: meal.imageURL)) { image in
            image.resizable()
            
        } placeholder: {
            Image(.mealPlaceholder)
                .resizable()
                .scaleEffect(1.25)
        }
        .scaledToFill()
        .frame(width: 120, height: 90)
        .cornerRadius(8)
    }
    
    private var title: some View {
        Text(meal.title)
            .font(.title3)
            .fontWeight(.semibold)
        
            .lineLimit(2)
            .minimumScaleFactor(0.75)
    }
    
    private var id: some View {
        Text(meal.id)
            .foregroundColor(.secondary)
    }
    
    init(for meal: Meal) {
        self.meal = meal
    }
}

#Preview {
    MealCellView(for: Meal.sampleItem)
}
