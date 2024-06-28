//
//  MealView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MealView: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            VStack {
                Text(meal.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(meal.id)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: meal.imageURL)) { image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
    
    init(for meal: Meal) {
        self.meal = meal
    }
}

#Preview {
    MealView(for: Meal.sampleItem)
}
