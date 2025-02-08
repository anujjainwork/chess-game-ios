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
                    gameViewModel.makeMove(from: Position(row: 1, column: 2), to: Position(row: 3, column: 2))
                }
            }

            
    }
}


#Preview {
    GameView(gameViewModel: GameViewModel())
}
