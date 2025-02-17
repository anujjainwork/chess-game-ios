//
//  ChessSquareView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct ChessSquareView: View {
    let position: Position
    @EnvironmentObject var gameViewModel: ChessBoardViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill((position.row + position.column) % 2 == 0 ? Color.lightCell : Color.darkCell)
                .overlay(highlightOverlay())
                
            if let piece = gameViewModel.getPiece(at: position) {
                Image(piece.imageName)
                    .resizable()
                    .scaledToFit()
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
