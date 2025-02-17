//
//  HomeView.swift
//  ChessMate
//
//  Created by Anuj Jain on 16/02/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameStatusVM: GameStatusViewModel
    @State private var isGameViewActive = false // State variable to trigger navigation

    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose game mode")
                    .font(.title)
                    .padding()

                Button("Pass and Play") {
                    gameStatusVM.chooseGameMode(choosedGameMode: GameMode.oneVsOne)
                    isGameViewActive = true
                }
                .buttonStyle(.borderedProminent)
                .padding()

                // Navigation link triggered by state change
                NavigationLink("", destination: FullBoardView(), isActive: $isGameViewActive)
            }
        }
    }
}
