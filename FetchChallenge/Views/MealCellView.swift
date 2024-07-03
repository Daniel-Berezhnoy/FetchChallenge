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
    let showingID: Bool
    
    var body: some View {
        HStack {
            image
            
            VStack(alignment: .leading, spacing: 8) {
                title
                if showingID { id }
            }
            .padding(.leading)
        }
        .padding(.vertical, 5)
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
        
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary, lineWidth: 0.25))
    }
    
    private var title: some View {
        Text(meal.title.capitalized)
            .font(.title3)
            .fontWeight(.semibold)
        
            .lineLimit(2)
            .minimumScaleFactor(0.75)
    }
    
    private var id: some View {
        Text(meal.id)
            .foregroundStyle(.secondary)
    }
    
    init(for meal: Meal, showingID: Bool) {
        self.meal = meal
        self.showingID = showingID
    }
}

#Preview {
    MealCellView(for: Meal.sample, showingID: true)
}
