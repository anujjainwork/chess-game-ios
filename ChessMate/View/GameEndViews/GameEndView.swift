//
//  GameDrawView 2.swift
//  ChessMate
//
//  Created by Anuj Jain on 18/02/25.
//


import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var gameStatusVM: GameStatusViewModel
    var isDraw: Bool
    var reason: String

    var body: some View {
        VStack {
            LottieView(animationName: isDraw ? "draw" : "win_animation")
                .frame(width: 200, height: 200)

            Text(reason)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8)) // Background overlay effect
    }
}
