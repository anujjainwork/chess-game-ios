//
//  GameViewModel.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var chessBoard = ChessBoard()
    @Published var moveHistory = MoveHistory()
    @Published var selectedPosition: Position?
    @Published var currentPlayer: PlayerType = .white
    @Published var capturedPiecesWhite: [ChessPiece] = []
    @Published var capturedPiecesBlack: [ChessPiece] = []

    /// Attempts to make a move from `from` position to `to` position.
    func makeMove(from: Position, to: Position) {
        guard let movingPiece = chessBoard.getPiece(at: from) else { return }
        
        if isValidMove(from: from, to: to, movingPiece: movingPiece, board: chessBoard) {
            
            if let capturedPiece = chessBoard.getPiece(at: to) {
                if capturedPiece.player == .white {
                    capturedPiecesWhite.append(capturedPiece)
                } else {
                    capturedPiecesBlack.append(capturedPiece)
                }
            }
            
            let move = Move(movedPiece: movingPiece, capturedPiece: chessBoard.getPiece(at: to), from: from, to: to)
            
            chessBoard.movePiece(from: from, to: to, moveHistory: &moveHistory)
            moveHistory.addMove(move)
            
            togglePlayerTurn()
        }
    }
    
    /// Toggles the current player after a successful move.
    private func togglePlayerTurn() {
        currentPlayer = (currentPlayer == .white) ? .black : .white
    }

    /// Handles the selection of a piece. If a piece is already selected, it attempts to move it.
    func selectPiece(at position: Position) {
        let piece = chessBoard.getPiece(at: position)

        // If a piece is already selected, retrieve it
        let selectedPiece = selectedPosition.flatMap { chessBoard.getPiece(at: $0) }

        // Allow selection or move only if the selected piece or clicked piece belongs to the current player
        if piece?.player == currentPlayer || selectedPiece?.player == currentPlayer {
            if let selected = selectedPosition {
                makeMove(from: selected, to: position)
                selectedPosition = nil
            } else {
                selectedPosition = position
            }
        } else {
            print("Invalid selection: It's not \(currentPlayer)'s turn.")
        }
    }

    /// Returns the chess piece at a given position.
    func getPiece(at position: Position) -> ChessPiece? {
        return chessBoard.getPiece(at: position)
    }

    /// Returns a formatted list of move history.
    func getMoveHistory() -> [String] {
        return moveHistory.getAllMoves().map { $0.description() }
    }
}
