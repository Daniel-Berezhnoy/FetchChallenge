//
//  MenuView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MenuView: View {
    @State private var meals: [Meal] = []
    
    var body: some View {
        List(meals, id: \.self) { meal in
            MealView(for: meal)
        }
//        .listStyle(.plain)
        .onAppear { loadMenu() }
        .refreshable { loadMenu() }
    }
    
    func loadMenu() {
        Task { meals = try await NetworkManager.shared.getMenuItems() }
    }
}

#Preview {
    MenuView()
}
