//
//  GameView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: ChessBoardViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let boardSize = min(geometry.size.width, geometry.size.height) * 0.9
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "#041F1F"), Color(hex: "#0A2E2E")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    CapturedPiecesView(chessBoardViewModel: gameViewModel, whiteCapturedPieces: false)
                        .frame(height: max(40, 60))
                        .shadow(radius: 5)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "#1C3636").opacity(0.95))
                        .frame(width: boardSize, height: boardSize * 1.02)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 4)
                        .overlay(
                            ChessBoardView(gameViewModel: gameViewModel)
                                .frame(width: boardSize * 0.96, height: boardSize * 0.99)
                                .offset(x: -5, y: 10)
                        )
                        
                    CapturedPiecesView(chessBoardViewModel: gameViewModel, whiteCapturedPieces: true)
                        .frame(height: max(40, 60))
                        .shadow(radius: 5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

// MARK: - Preview
#Preview {
    GameView(gameViewModel: ChessBoardViewModel())
}
