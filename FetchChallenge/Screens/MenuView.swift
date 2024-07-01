//
//  MenuView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MenuView: View {
    
    @State private var meals: [Meal] = []
    @Binding var showID: Bool
    
    var body: some View {
        NavigationStack {
            List(meals, id: \.self) { meal in
    
                NavigationLink {
                    MealDetailView(for: meal)
                } label: {
                    MealCellView(for: meal, showingID: showID)
                }
            }
            .navigationTitle("Menu")
            
            .onAppear { loadMenu() }
            .refreshable { loadMenu() }
        }
    }
    
    func loadMenu() {
        Task { meals = try await NetworkManager.shared.getMenuItems() }
    }
}

#Preview {
    MenuView(showID: .constant(true))
}
