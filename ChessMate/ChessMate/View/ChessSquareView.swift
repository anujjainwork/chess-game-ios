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
                .fill((position.row + position.column) % 2 == 0 ? Color.white : Color.gray)
                .overlay(gameViewModel.selectedPosition == position
                         ? Rectangle().fill(Color.blue.opacity(0.4)) : nil )
                .frame(width: 50, height: 50)

            if let piece = gameViewModel.getPiece(at: position) {
                Text(piece.displaySymbol)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            gameViewModel.selectPiece(at: position)
        }
    }
}
