//
//  Move.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

struct Move {
    var movedPiece: ChessPiece
    var capturedPiece: ChessPiece?
    var from : Position
    var to : Position
    
    func description() -> String {
        var fromString : String = "\(from.column.toChessColumn)\(8 - from.row)"
        var toString : String = "\(to.column.toChessColumn)\(8 - to.row)"
        
            if let capturedPiece = capturedPiece {
                return "\(movedPiece.displaySymbol)\(fromString)x\(toString)"
            } else {
                return "\(movedPiece.displaySymbol)\(fromString)-\(toString)"
            }
    }
    
    
}
