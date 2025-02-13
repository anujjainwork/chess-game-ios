//
//  ChessSquareView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct ChessSquareView: View {
    let position: Position
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill((position.row + position.column) % 2 == 0 ? Color(hex: "#DEE3C3") : Color(hex: "#166060"))
                .overlay(highlightOverlay())
                
            if let piece = gameViewModel.getPiece(at: position) {
                Text(piece.displaySymbol)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            gameViewModel.selectPiece(at: position)
        }
    }
    
    @ViewBuilder
    private func highlightOverlay() -> some View {
        if gameViewModel.selectedPosition == position {
            Rectangle().fill(Color.blue.opacity(0.4))
        } else if gameViewModel.kingInCheckPosition == position {
            Rectangle().fill(Color.red.opacity(0.4))
        } else if gameViewModel.highlightValidMoves.contains(position) {
            Circle().fill(Color.green.opacity(0.4)).frame(width: 20, height: 20)
        }
    }
}
