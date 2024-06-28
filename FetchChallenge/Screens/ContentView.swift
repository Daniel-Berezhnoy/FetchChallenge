//
//  ContentView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [MenuItem] = []
    
    var body: some View {
        List(items, id: \.self) { menuItem in
            MenuItemCell(for: menuItem)
        }
        .listStyle(.plain)
        .onAppear { getMenu() }
        .refreshable { getMenu() }
    }
    
    func getMenu() {
        Task { items = try await NetworkManager.shared.getMenuItems() }
    }
}

#Preview {
    ContentView()
}
