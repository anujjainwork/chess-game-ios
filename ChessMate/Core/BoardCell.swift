//
//  BoardCell.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

struct BoardCell {
    var position : Position
    var chessPiece : ChessPiece?
    
    func copy() -> BoardCell {
        return BoardCell(position: self.position, chessPiece: self.chessPiece?.copy())
    }

}

struct Position : Equatable {
    var row : Int
    var column : Int
}
