//
//  MoveValidator.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

func isValidMove(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard) -> Bool {
    _ = from.row * 8 + from.column
    let toIndex = to.row * 8 + to.column
    
    // Prevent moving onto a piece of the same player
    if let destinationPiece = board.board[toIndex].chessPiece,
       destinationPiece.player == movingPiece.player {
        return false
    }

    switch movingPiece.rank {
    case .pawn:
        return isValidForPawn(from: from, to: to, movingPiece: movingPiece, board: board)
    case .rook:
        return isValidForRook(from: from, to: to, board: board)
    case .knight:
        return isValidForKnight(from: from, to: to)
    case .bishop:
        return isValidForBishop(from: from, to: to, board: board)
    case .queen:
        return isValidForQueen(from: from, to: to, board: board)
    case .king:
        return isValidForKing(from: from, to: to)
    }
}

// MARK: - Pawn Move Validation
private func isValidForPawn(from: Position, to: Position, movingPiece: ChessPiece, board: ChessBoard) -> Bool {
    let isWhite = movingPiece.player == .white
    let direction = isWhite ? -1 : 1
    _ = from.row * 8 + from.column
    let toIndex = to.row * 8 + to.column

    // Forward move
    if from.column == to.column {
        if board.board[toIndex].chessPiece != nil {
            return false
        }
        if to.row - from.row == direction {
            return true
        }
        if (from.row == 1 && !isWhite) || (from.row == 6 && isWhite) {
            let stepIndex = (from.row + direction) * 8 + from.column
            return (to.row - from.row == 2 * direction || to.row - from.row == direction) && board.board[stepIndex].chessPiece == nil
        }
    }

    // Diagonal capture
    if abs(to.column - from.column) == 1 && (to.row - from.row) == direction {
        return board.board[toIndex].chessPiece != nil
    }

    return false
}

// MARK: - Rook Move Validation
private func isValidForRook(from: Position, to: Position, board: ChessBoard) -> Bool {
    if from.row != to.row && from.column != to.column {
        return false
    }

    let rowStep = (to.row - from.row).signum()
    let colStep = (to.column - from.column).signum()

    var currentRow = from.row + rowStep
    var currentCol = from.column + colStep

    while currentRow != to.row || currentCol != to.column {
        if board.board[currentRow * 8 + currentCol].chessPiece != nil {
            return false
        }
        currentRow += rowStep
        currentCol += colStep
    }

    return true
}

// MARK: - Knight Move Validation
private func isValidForKnight(from: Position, to: Position) -> Bool {
    let rowDiff = abs(to.row - from.row)
    let colDiff = abs(to.column - from.column)
    return (rowDiff == 2 && colDiff == 1) || (rowDiff == 1 && colDiff == 2)
}

// MARK: - Bishop Move Validation
private func isValidForBishop(from: Position, to: Position, board: ChessBoard) -> Bool {
    if abs(to.row - from.row) != abs(to.column - from.column) {
        return false
    }

    let rowStep = (to.row - from.row).signum()
    let colStep = (to.column - from.column).signum()

    var currentRow = from.row + rowStep
    var currentCol = from.column + colStep

    while currentRow != to.row || currentCol != to.column {
        if board.board[currentRow * 8 + currentCol].chessPiece != nil {
            return false
        }
        currentRow += rowStep
        currentCol += colStep
    }

    return true
}

// MARK: - Queen Move Validation
private func isValidForQueen(from: Position, to: Position, board: ChessBoard) -> Bool {
    return isValidForRook(from: from, to: to, board: board) || isValidForBishop(from: from, to: to, board: board)
}

// MARK: - King Move Validation
private func isValidForKing(from: Position, to: Position) -> Bool {
    let rowDiff = abs(to.row - from.row)
    let colDiff = abs(to.column - from.column)
    return rowDiff <= 1 && colDiff <= 1
}
