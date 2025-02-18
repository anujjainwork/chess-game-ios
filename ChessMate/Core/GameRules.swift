//
//  GameRules.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

/// Checks if the king is in check or not.
func isKingInCheck(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard, whiteKingPosition: Position, blackKingPosition: Position) -> Position? {
    
    let opponentKingPosition: Position = movingPiece.player == .white ? blackKingPosition : whiteKingPosition

    if isValidMove(from: to, to: opponentKingPosition, movingPiece: movingPiece, board: board) {
        return opponentKingPosition
    }
    return nil
}

/// Checks if the current move resolves check or not.
func doesResolveCheck(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard, whiteKingPosition: Position, blackKingPosition: Position) -> Bool {
    
    var tempBoard = board.copy()
    
    let backupFromPiece = tempBoard.getPiece(at: from)
    let backupToPiece = tempBoard.getPiece(at: to)
    
    let currentKingPosition = (movingPiece.player == .white) ? whiteKingPosition : blackKingPosition
    var updatedKingPosition = currentKingPosition

    tempBoard.setPiece(at: from, piece: nil)
    tempBoard.setPiece(at: to, piece: movingPiece)
    
    if movingPiece.rank == .king {
        updatedKingPosition = to
    }

    let stillInCheck = isKingStillInCheck(for: movingPiece.player, board: tempBoard, kingPosition: updatedKingPosition)

    tempBoard.setPiece(at: from, piece: backupFromPiece)
    tempBoard.setPiece(at: to, piece: backupToPiece)

    return !stillInCheck
}



func findAttackingPieces(for player: PlayerType, board: ChessBoard, kingPosition: Position) -> [ChessPiece] {
    var attackers: [ChessPiece] = []
    
    for cell in board.board {
        if let piece = cell.chessPiece, piece.player != player {
            if isValidMove(from: cell.position, to: kingPosition, movingPiece: piece, board: board) {
                print("🚨 King is under attack by \(piece.rank) from \(cell.position)!")
                attackers.append(piece)
            }
        }
    }
    
    return attackers
}


/// Check if there is checkmate
func isCheckMate(chessBoard: ChessBoard, attackingPlayer: PlayerType, whiteKingPosition: Position, blackKingPosition: Position) -> Bool {
    
    let defendingPlayer = (attackingPlayer == .white) ? PlayerType.black : PlayerType.white

    for cell in chessBoard.board {
        if let piece = cell.chessPiece, piece.player == defendingPlayer {
            let from = cell.position

            for targetCell in chessBoard.board {
                let to = targetCell.position
                
                
                if  isValidMove(from: from, to: to, movingPiece: piece, board: chessBoard) && doesResolveCheck(from: from, to: to, movingPiece: piece, board: chessBoard, whiteKingPosition: whiteKingPosition, blackKingPosition: blackKingPosition) {
                    return false // A move exists that prevents checkmate
                }
            }
        }
    }

    return true // No valid moves found → Checkmate
}

/// Checks if the king is still in check after a move.
func isKingStillInCheck(for player: PlayerType, board: ChessBoard, kingPosition: Position) -> Bool {
    
    for cell in board.board {
        if let piece = cell.chessPiece, piece.player != player {
            if isValidMove(from: cell.position, to: kingPosition, movingPiece: piece, board: board) {
                return true // King is still under attack
            }
        }
    }
    
    return false
}

/// Returns all the valid moves in a list
func getAllValidMovesToHighlight(at from: Position, chessBoard: ChessBoard, kingInCheckPosition: Position?, whiteKingPosition: Position, blackKingPosition: Position) -> [Position] {
    var validMovesList: [Position] = []
    for cell in chessBoard.board{
        if kingInCheckPosition == nil {
            if isValidMove(from: from, to: cell.position, movingPiece: chessBoard.getPiece(at: from)!, board: chessBoard) {
                validMovesList.append(cell.position)
            }
        }
        else {
            if isValidMove(from: from, to: cell.position, movingPiece: chessBoard.getPiece(at: from)!, board: chessBoard) && doesResolveCheck(from: from, to: cell.position, movingPiece: chessBoard.getPiece(at: from)!, board: chessBoard, whiteKingPosition: whiteKingPosition, blackKingPosition: blackKingPosition){
                validMovesList.append(cell.position)
            }
        }
    }
    return validMovesList
}
