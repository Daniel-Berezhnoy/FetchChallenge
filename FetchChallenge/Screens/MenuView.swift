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
    @Binding var accentColor: Color
    
    var body: some View {
        NavigationStack {
            ZStack {
                loadingSpinner
                menuList
            }
            .navigationTitle("Menu")
            .onAppear { loadMenu() }
            .refreshable { loadMenu() }
        }
    }
    
    #warning("Change")
    private var loadingSpinner: some View {
        Text("Change This")
    }
    
    private var menuList: some View {
        List(meals, id: \.self) { meal in
            NavigationLink {
                MealDetailView(for: meal, accentColor: accentColor)
            } label: {
                MealCellView(for: meal, showingID: showID)
            }
        }
    }
    
    private func loadMenu() {
        Task { meals = try await NetworkManager.shared.getMenuItems() }
    }
}

#Preview {
    MenuView(showID: .constant(true), accentColor: .constant(.pink))
}
