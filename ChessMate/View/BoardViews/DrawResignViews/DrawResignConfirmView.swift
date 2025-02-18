//
//  DrawResignConfirmation.swift
//  ChessMate
//
//  Created by Anuj Jain on 18/02/25.
//

import SwiftUI

struct DrawResignConfirmation: View {
    var width: Double
    var height: Double
    var isDraw: Bool
    var isWhiteTurn: Bool
    var currentPlayter: PlayerType

    @Binding var drawConfirmation: Bool
    @Binding var resignConfirmation: Bool
    @Binding var gameDrawn : Bool
    @Binding var gameWonByWhite : Bool
    @Binding var gameWonByBlack : Bool
    
    @EnvironmentObject var gameStatusVM: GameStatusViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width, height: height)
                .foregroundColor(Color.white.opacity(0.5))

            VStack {
                Text(isDraw ? "Do you want a draw?" : "Do you want to resign?")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                HStack(spacing: 40) {
                    Button("Yes") {
                        handleConfirmation()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                    Button("No") {
                        handleCancellation()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
            }
            .padding()
        }
        .rotationEffect(.degrees(isWhiteTurn ? 0 : 180))
    }

    private func handleConfirmation() {
        if isDraw {
            gameStatusVM.updateGameStatusToDraw()
            gameDrawn = true
        } else {
            let winningPlayer : PlayerType = (currentPlayter == PlayerType.white) ? PlayerType.black : PlayerType.white
            gameStatusVM.updateGameStatusToWin(winner: winningPlayer)
            
            if winningPlayer == PlayerType.white {
                gameWonByWhite = true
            } else {
                gameWonByBlack = true
            }
        }
        drawConfirmation = false
        resignConfirmation = false
    }

    private func handleCancellation() {
        drawConfirmation = false
        resignConfirmation = false
    }
}
