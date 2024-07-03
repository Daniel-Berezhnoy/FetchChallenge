//
//  FCTabView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 7/3/24.
//

import SwiftUI

// Add Color Selection
// Add Comments

struct FCTabView: View {
    
    @State private var accentColor = Color.blue
    @State private var showID = true
    
    var body: some View {
        TabView {
            menu
            settings
        }
        .tint(accentColor)
    }
    
    // Screens
    private var menu: some View {
        MenuView(showID: $showID, accentColor: $accentColor)
            .tabItem {
                Label {
                    Text("Menu")
                } icon: {
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                }
            }
    }
    
    private var settings: some View {
        SettingsView(showID: $showID, accentColor: accentColor)
            .tabItem {
                Label {
                    Text("Settings")
                } icon: {
                    Image(systemName: "gear")
                }
            }
    }
}

#Preview {
    FCTabView()
}
