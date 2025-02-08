//
//  MoveHistory.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

class MoveHistory {
    var moves : [Move] = []
    
    func addMove(_ move: Move) {
        moves.append(move)
    }
    
    func getAllMoves() -> [Move]{
        return self.moves
    }
    
    func printMoveHistory() {
        for (index, move) in moves.enumerated() {
            print("\(index + 1). \(move.description())")
        }
    }
}
