//
//  MenuView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MenuView: View {
    
    @State private var searchTerm = ""
    @State private var meals: [Meal] = []
    
    @Binding var showID: Bool
    @Binding var accentColor: Color
    
    var body: some View {
        NavigationStack {
            ZStack {
                menuList
                loadingSpinner
            }
            .navigationTitle("Menu")
            .onAppear { loadMenu() }
            .refreshable { loadMenu() }
        }
        .searchable(text: $searchTerm)
    }
    
    // MARK: Views
    private var menuList: some View {
        List(searchResults) { meal in
            NavigationLink {
                MealDetailView(for: meal, accentColor: accentColor)
            } label: {
                MealCellView(for: meal, showingID: showID)
            }
        }
    }
    
    private var loadingSpinner: some View {
        ZStack {
            if meals.isEmpty {
                VStack(spacing: 13) {
                    ProgressView()
                        .controlSize(.extraLarge)
                    
                    Text("Loading...")
                        .font(.headline)
                        .foregroundStyle(accentColor)
                        .opacity(0.75)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
                .background { Color(uiColor: .systemBackground) }
            }
        }
    }
    
    // MARK: Computed Properties
    private var searchResults: [Meal] {
        if searchTerm.isEmpty {
            return meals
        } else {
            return meals.filter { $0.title.contains(searchTerm) || $0.id.contains(searchTerm) }
        }
    }
    
    // MARK: Functions
    private func loadMenu() {
        Task { meals = try await NetworkManager.shared.getMenuItems() }
    }
}

#Preview {
    MenuView(showID: .constant(true), accentColor: .constant(.pink))
}
