//
//  FetchChallengeApp.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

@main
struct FetchChallengeApp: App {
    
    @State private var accentColor = Color.purple
    @State private var showID = true
    
    var body: some Scene {
        WindowGroup {
            TabView {
                menu
                settings
            }
            .tint(accentColor)
        }
    }
    
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
