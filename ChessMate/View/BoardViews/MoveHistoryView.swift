//
//  MoveHistoryView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct MoveHistoryView: View {
    @EnvironmentObject var chessBoardVM : ChessBoardViewModel
    @EnvironmentObject var moveHistoryVM: MoveHistoryViewModel
    var player : PlayerType

    var body: some View {
        HStack {
            Button(action: {
                moveHistoryVM.undoMove()
            }) {
                Image("back-button")
                    .opacity(moveHistoryVM.undoEnabled && (player == chessBoardVM.currentPlayer) ? 1.0 : 0.5)
            }
            .disabled(!moveHistoryVM.undoEnabled && (player != chessBoardVM.currentPlayer))

            Button(action: {
                moveHistoryVM.redoMove()
            }) {
                Image("forward-button")
                    .opacity(moveHistoryVM.redoEnabled && (player == chessBoardVM.currentPlayer) ? 1.0 : 0.5)
            }
            .disabled(!moveHistoryVM.redoEnabled && (player != chessBoardVM.currentPlayer))
        }
    }
}
