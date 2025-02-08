//
//  GameRules.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

/// Checks if the king is in check or not.
func isKingInCheck(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard, whiteKingPosition: Position, blackKingPosition: Position) -> Position? {
    
    var opponentKingPosition : Position = movingPiece.player == PlayerType.white ? blackKingPosition : whiteKingPosition
    
    if(isValidMove(from: to, to: opponentKingPosition, movingPiece: movingPiece, board: board)){
        return opponentKingPosition
    }
    return nil
}

/// Checks if the current move resolves check or not.
func doesResolveCheck(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard, whiteKingPosition: Position, blackKingPosition: Position) -> Bool {
    
    let currentKingPosition = (movingPiece.player == .white) ? whiteKingPosition : blackKingPosition

    var tempBoard = board

    // Simulate the move using your existing method
    var tempMoveHistory = MoveHistory()
    
    tempBoard.movePiece(from: from, to: to, moveHistory: &tempMoveHistory)

    // Check if the king is still in check after the move
    for cell in tempBoard.board {
        if let piece = cell.chessPiece, piece.player != movingPiece.player {
            if isValidMove(from: cell.position, to: currentKingPosition, movingPiece: piece, board: tempBoard) {
                return false // King is still in check, move does NOT resolve check
            }
        }
    }
    
    return true // Move successfully resolves check
}


