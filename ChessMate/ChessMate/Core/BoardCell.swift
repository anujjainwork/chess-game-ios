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
}

struct Position : Equatable {
    var row : Int
    var column : Int
}
