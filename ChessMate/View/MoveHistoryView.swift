//
//  MoveHistoryView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct MoveHistoryView: View {
    @EnvironmentObject var moveHistoryVM: MoveHistoryViewModel

    var body: some View {
        HStack {
            Button(action: {
                moveHistoryVM.undoMove()
            }) {
                Image("back-button")
                    .opacity(moveHistoryVM.undoEnabled ? 1.0 : 0.5)
            }
            .disabled(!moveHistoryVM.undoEnabled)

            Button(action: {
                moveHistoryVM.redoMove()
            }) {
                Image("forward-button")
                    .opacity(moveHistoryVM.redoEnabled ? 1.0 : 0.5)
            }
            .disabled(!moveHistoryVM.redoEnabled)
        }
    }
}
