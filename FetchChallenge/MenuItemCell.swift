//
//  MenuItemCell.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import SwiftUI

struct MenuItemCell: View {
    
    let menuItem: MenuItem
    
    var body: some View {
        HStack {
            VStack {
                Text(menuItem.strMeal)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(menuItem.idMeal)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: menuItem.strMealThumb)) { image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
    
    init(for menuItem: MenuItem) {
        self.menuItem = menuItem
    }
}

#Preview {
    MenuItemCell(for: MenuItem.sampleItem)
}
