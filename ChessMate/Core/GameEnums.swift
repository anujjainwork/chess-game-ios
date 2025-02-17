//
//  GameEnums.swift
//  ChessMate
//
//  Created by Anuj Jain on 16/02/25.
//

import Foundation

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

enum GameStatus {
    case initial
    case playing(gameMode: GameMode)
    case win(whoWon: PlayerType)
    case draw
}

enum GameMode {
    case oneVsOne, oneVsBot
}
