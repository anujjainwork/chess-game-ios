//
//  ChessPiece.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

import Foundation

struct ChessPiece: Identifiable {
    var id = UUID()
    var rank: Rank
    var player: PlayerType

    var imageName: String {
        let prefix = player == .white ? "white" : "black"
        switch rank {
        case .king: return "king_\(prefix)"
        case .queen: return "queen_\(prefix)"
        case .rook: return "rook_\(prefix)"
        case .bishop: return "bishop_\(prefix)"
        case .knight: return "knight_\(prefix)"
        case .pawn: return "pawn_\(prefix)"
        }
    }

    func copy() -> ChessPiece {
        return ChessPiece(rank: self.rank, player: self.player)
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

