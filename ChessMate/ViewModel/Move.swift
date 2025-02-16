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
        let fromString : String = "\(from.column.toChessColumn)\(8 - from.row)"
        let toString : String = "\(to.column.toChessColumn)\(8 - to.row)"
        
        if capturedPiece != nil {
                return "\(movedPiece.imageName)\(fromString)x\(toString)"
            } else {
                return "\(movedPiece.imageName)\(fromString)-\(toString)"
            }
    }
    
    
}
