//
//  GameView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let boardSize = min(geometry.size.width, geometry.size.height) * 0.9
            
            ZStack {
                Color(hex: "#072323")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(hex: "#1C3636"))
                        .frame(width: boardSize, height: boardSize * 1.02)
                        .overlay(
                            ChessBoardView(gameViewModel: gameViewModel)
                                .frame(width: boardSize * 0.96, height: boardSize * 0.99)
                                .offset(x: -5, y:10)
                        )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

// MARK: - Preview
#Preview {
    GameView(gameViewModel: GameViewModel())
}
