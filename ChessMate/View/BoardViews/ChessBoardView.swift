//
//  ChessBoardView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct ChessBoardView: View {
    @EnvironmentObject var moveHistoryVM: MoveHistoryViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let squareSize = geometry.size.width / 9
            
            VStack(spacing: 0) {
                // Rank Labels (8-1) on the Left
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        ForEach((1...8).reversed(), id: \ .self) { row in
                            Text("\(row)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: squareSize, height: squareSize)
                        }
                    }
                    
                    // Chess Board
                    if moveHistoryVM.backToMainGame {
                    VStack(spacing: 0) {
                        ForEach(0..<8, id: \ .self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<8, id: \ .self) { col in
                                        ChessSquareView(position: Position(row: row, column: col))
                                            .frame(width: squareSize, height: squareSize)
                                            .transition(.opacity)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        VStack(spacing: 0) {
                            ForEach(0..<8, id: \ .self) { row in
                                HStack(spacing: 0) {
                                    ForEach(0..<8, id: \ .self) { col in
                                        HistorySquareView(position: Position(row: row, column: col))
                                            .frame(width: squareSize, height: squareSize)
                                            .transition(.opacity)
                                        }
                                    }
                                }
                            }
                   }
                }
                
                // File Labels (A-H) at the Bottom
                HStack(spacing: 0) {
                    Text("")
                        .frame(width: squareSize)
                    
                    let fileLetters = ["A", "B", "C", "D", "E", "F", "G", "H"]
                    ForEach(fileLetters, id: \ .self) { letter in
                        Text(letter)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: squareSize, height: squareSize)
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
