//
//  HistoryBoardView.swift
//  ChessMate
//
//  Created by Anuj Jain on 15/02/25.
//

import SwiftUI

struct HistorySquareView: View {
    let position: Position
    @EnvironmentObject var moveHistoryVM: MoveHistoryViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill((position.row + position.column) % 2 == 0 ? Color.lightCell : Color.darkCell)
                
            if let piece = moveHistoryVM.currentBoard.getPiece(at: position){
                Image(piece.imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
