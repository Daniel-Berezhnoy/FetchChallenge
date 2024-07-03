//
//  SettingsView.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/30/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showID: Bool
    @Binding var accentColor: Color
    
    var body: some View {
        NavigationStack {
            List {
                dessertIDToggle
                colorPicker
            }
            .navigationTitle("Settings")
        }
    }
    
    // MARK: Views
    private var dessertIDToggle: some View {
        Toggle(isOn: $showID) {
            Label {
                Text("Show Dessert ID")
            } icon: {
                Image(systemName: "person.text.rectangle.fill")
                    .foregroundStyle(accentColor)
            }
        }
        .tint(accentColor)
    }
    
    private var colorPicker: some View {
        ColorPicker(selection: $accentColor) {
            Label {
                Text("Accent Color")
            } icon: {
                Image(systemName: "paintpalette.fill")
                    .foregroundStyle(accentColor)
            }
        }
    }
}

#Preview {
    return SettingsView(showID: .constant(true), accentColor: .constant(.pink))
}
