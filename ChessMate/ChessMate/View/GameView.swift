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
            VStack {
//                MoveHistoryView(gameViewModel: gameViewModel)
//                    .frame(width: 200)
                ChessBoardView(gameViewModel: gameViewModel)
//                GameControlsView(gameViewModel: gameViewModel)
                
                Button("Move"){
                    gameViewModel.makeMove(from: Position(row: 6, column: 4), to: Position(row: 5, column: 4))
                    gameViewModel.makeMove(from: Position(row: 1, column: 0), to: Position(row: 2, column: 0))
                    gameViewModel.makeMove(from: Position(row: 7, column: 3), to: Position(row: 3, column: 7))
                    gameViewModel.makeMove(from: Position(row: 2, column: 0), to: Position(row: 3, column: 0))
                    gameViewModel.makeMove(from: Position(row: 7, column: 5), to: Position(row: 4, column: 2))
                    gameViewModel.makeMove(from: Position(row: 3, column: 0), to: Position(row: 4, column: 0))
                    gameViewModel.makeMove(from: Position(row: 7, column: 5), to: Position(row: 4, column: 2))
                    gameViewModel.makeMove(from: Position(row: 4, column: 0), to: Position(row: 5, column: 0))
//                    gameViewModel.makeMove(from: Position(row: 0, column: 3), to: Position(row: 4, column: 7)) // Black queen to h4# (Checkmate)

                }
            }

            
    }
}


#Preview {
    GameView(gameViewModel: GameViewModel())
}
