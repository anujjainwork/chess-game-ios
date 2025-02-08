//
//  BoardView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct ChessBoardView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            let squareSize = geometry.size.width / 8
            
            VStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            ChessSquareView(position: Position(row: row, column: col),
                                            gameViewModel: gameViewModel)
                                .frame(width: squareSize, height: squareSize)
                        }
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

