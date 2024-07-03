//
//  MealDetailView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MealDetailView: View {
    
    @State private var limitLines = true
    @State private var dessert: Dessert?
    
    let meal: Meal
    let accentColor: Color
    
    let fallbackYTLink = "https://www.youtube.com/watch?v=mhDJNfV7hjk"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    image
                    titleSubtitle
                }
                cookingInstructions
                seeMoreButton
                ingredients
                ytButton
            }
            .padding(.bottom)
        }
        .navigationTitle("Details")
        .toolbarTitleDisplayMode(.inline)
        .background { backgroundImage }
        
        .onAppear { loadMealDetails() }
        .refreshable { loadMealDetails() }
    }
    
    // MARK: Views
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
            
            Text(dessert?.cuisine.capitalized ?? "Loading...")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 7)
        .background(Material.ultraThin.opacity(0.75))
        
        .clipShape(.rect(topLeadingRadius: 0,
                         bottomLeadingRadius: 0,
                         bottomTrailingRadius: 20,
                         topTrailingRadius: 20,
                         style: .continuous)
        )
    }
    
    private var cookingInstructions: some View {
        VStack(alignment: .leading) {
            Text("Cooking Instructions:")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(formattedInstructions)
                .lineLimit(limitLines ? 3 : 300)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var seeMoreButton: some View {
        Button {
            withAnimation(.bouncy(duration: 0.3)) { limitLines.toggle() }
        } label: {
            Label {
                Text(limitLines ? "See More" : "See Less")
            } icon: {
                Image(systemName: limitLines ? "chevron.down" : "chevron.up")
            }
            .fontWeight(.medium)
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.borderedProminent)
        
        .tint(.secondary.opacity(0.5))
        .foregroundStyle(Color(uiColor: .systemBackground))
        
        .padding(.horizontal)
    }
    
    private var ingredients: some View {
        VStack(alignment: .leading) {
            Text("Ingredients:")
                .font(.headline)
                .fontWeight(.semibold)
            
            ingredientList
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var ingredientList: some View {
        ForEach(dessert?.measuredIngredients ?? loadingIngredients) { combined in
            HStack {
                Text(combined.ingredient.capitalized)
                Spacer()
                Text(combined.measurement)
            }
        }
    }
    
    private var ytButton: some View {
        Link(destination: (URL(string: dessert?.ytLink ?? fallbackYTLink)!)) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundStyle(.foreground)
                    .opacity(0.4)
                
                Text("Watch Video")
                    .foregroundStyle(Color(uiColor: .systemBackground))
                    .font(.headline)
            }
        }
        .padding(.top)
        .padding(.bottom, 25)
        .padding(.horizontal, 13)
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
    
    // MARK: Computed Properties
    private var formattedInstructions: String {
        dessert?.instructions
            .replacingOccurrences(of: "\n\r", with: "")
            .replacingOccurrences(of: "\r\n", with: "\r\n\r\n")
        ?? ""
    }
    
    private var loadingIngredients: [Dessert.MeasuredIngredient] {
        return [Dessert.MeasuredIngredient(ingredient: "Loading...", measurement: "Loading...")]
    }
    
    // MARK: Functions
    private func loadMealDetails() {
        Task { dessert = try await NetworkManager.shared.findDessert(withID: meal.id) }
    }
    
    // MARK: Init
    init(for meal: Meal, accentColor: Color) {
        self.meal = meal
        self.accentColor = accentColor
    }
}

#Preview {
    MealDetailView(for: Meal.sample, accentColor: .blue)
        .ignoresSafeArea()
}
