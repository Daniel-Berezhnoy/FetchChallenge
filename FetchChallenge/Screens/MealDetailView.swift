//
//  MealDetailView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MealDetailView: View {
    
    let meal: Meal
    let accentColor: Color
    
    @State private var limitLines = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    image
                    titleSubtitle
                }
                cookingInstructions
                ingredients
            }
        }
        .navigationTitle("Details")
        .toolbarTitleDisplayMode(.inline)
        .background { backgroundImage }
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: meal.imageURL)) { image in
            image
                .resizable()
                .scaledToFit()
                .offset(y: -3)
            
        } placeholder: {
            Image(systemName: "carrot")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .padding(90)
        }
        .saturation(1.3)
        
        .mask(LinearGradient(gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 1),
            .init(color: .clear, location: 1),
            .init(color: .black, location: 1),
            
        ]), startPoint: .top, endPoint: .bottom))
    }
    
    private var titleSubtitle: some View {
        VStack(alignment: .leading) {
            Text(meal.title.capitalized)
                .font(.title)
                .fontWeight(.bold)
            
            Text("british".capitalized)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.white.opacity(0.75))
        }
        .shadow(radius: 40)
        .padding(.horizontal)
    }
    
    private var cookingInstructions: some View {
        VStack(alignment: .leading) {
            Text("Cooking Instructions:")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(instructions)
                .lineLimit(limitLines ? 3 : 100)
            
            Button(limitLines ? "See more..." : "See less...") {
                withAnimation(.bouncy) {
                    limitLines.toggle()
                }
            }
            .tint(accentColor)
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
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .opacity(0.5)
            
            AsyncImage(url: URL(string: meal.imageURL)) { image in
                image.image?
                    .resizable()
                    .scaledToFill()
            }
            .opacity(0.4)
            .blur(radius: 20)
            .saturation(0.75)
            
            .scaleEffect(x: -1, y: 1, anchor: .center)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
    
    let instructions = "Heat oven to 180C/160C fan/gas 4 and line the base and sides of a 20cm square tin with baking parchment (the easiest way is to cross 2 x 20cm-long strips over the base). To make the almond sponge, put the butter, sugar, flour, ground almonds, baking powder, eggs, vanilla and almond extract in a large bowl. Beat with an electric whisk until the mix comes together smoothly. Scrape into the tin, spreading to the corners, and bake for 25-30 mins 2013 when you poke in a skewer, it should come out clean. Cool in the tin for 10 mins, then transfer to a wire rack to finish cooling while you make the second sponge.\r\nFor the pink"
    
    init(for meal: Meal, accentColor: Color) {
        self.meal = meal
        self.accentColor = accentColor
    }
}

#Preview {
    MealDetailView(for: Meal.sampleItem, accentColor: .pink)
}
