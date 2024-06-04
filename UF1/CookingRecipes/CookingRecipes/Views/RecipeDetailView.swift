
//
//  RecipeStatusView.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 11/3/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let isFavorite:Bool
    var body: some View {
      Circle()
        .padding(4)
        .overlay(
            Circle()
            .stroke(isFavorite ? Color.green : Color.red, lineWidth: 2)
        )
        .foregroundColor(isFavorite ? .green : .clear)
        .frame(width: 20, height: 20)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(isFavorite: true)
    }
}
