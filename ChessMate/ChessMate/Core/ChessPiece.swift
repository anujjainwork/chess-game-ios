//
//  ChessPiece.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

struct ChessPiece {
    var rank: Rank
    var player: PlayerType

    var displaySymbol: String {
        switch (player, rank) {
        case (.white, .king): return "♔"
        case (.white, .queen): return "♕"
        case (.white, .rook): return "♖"
        case (.white, .bishop): return "♗"
        case (.white, .knight): return "♘"
        case (.white, .pawn): return "♙"
        case (.black, .king): return "♚"
        case (.black, .queen): return "♛"
        case (.black, .rook): return "♜"
        case (.black, .bishop): return "♝"
        case (.black, .knight): return "♞"
        case (.black, .pawn): return "♟"
        }
    }
}

enum Rank {
    case king, queen, bishop, knight, rook, pawn
}

enum PlayerType {
    case white, black

    var displayName: String {
        switch self {
        case .white: return "White"
        case .black: return "Black"
        }
    }
}

