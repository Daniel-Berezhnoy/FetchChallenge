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
            VStack(alignment: .leading) {
                image
                titleSubtitle
                cookingInstructions
                ingredients
            }
        }
        .navigationTitle("Details")
        .toolbarTitleDisplayMode(.inline)
        .background { backgroundImage }
    }
    
    private var image: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
            
            AsyncImage(url: URL(string: meal.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .offset(y: -5)
                
            } placeholder: {
                Image(systemName: "carrot")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
                    .padding(90)
            }
            
            
        }
        .mask(LinearGradient(gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 1),
            
                .init(color: .clear, location: 1),
            .init(color: .black, location: 1),
            
        ]), startPoint: .top, endPoint: .bottom))
    }
    
    private var titleSubtitle: some View {
        VStack(alignment: .leading) {
            Text(meal.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text("British")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    
    private var cookingInstructions: some View {
        VStack(alignment: .leading) {
            Text("Cooking Instructions:")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(instructions)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var ingredients: some View {
        VStack(alignment: .leading) {
            Text("Ingredients:")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack {
                Text("esg")
                Text("esg")
                Text("esg")
                Text("esg")
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var backgroundImage: some View {
        AsyncImage(url: URL(string: meal.imageURL)) { image in
            image.image?
                .resizable()
                .scaledToFill()
        }
        .opacity(0.4)
        .blur(radius: 20)
        .ignoresSafeArea(.all, edges: .all)
    }
    
    let instructions = "Heat oven to 180C/160C fan/gas 4 and line the base and sides of a 20cm square tin with baking parchment (the easiest way is to cross 2 x 20cm-long strips over the base). To make the almond sponge, put the butter, sugar, flour, ground almonds, baking powder, eggs, vanilla and almond extract in a large bowl. Beat with an electric whisk until the mix comes together smoothly. Scrape into the tin, spreading to the corners, and bake for 25-30 mins 2013 when you poke in a skewer, it should come out clean. Cool in the tin for 10 mins, then transfer to a wire rack to finish cooling while you make the second sponge.\r\nFor the pink"
    
    init(for meal: Meal) {
        self.meal = meal
    }
}

#Preview {
    MealDetailView(for: Meal.sampleItem)
}
