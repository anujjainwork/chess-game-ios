//
//  GameViewModel.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

class ChessBoardViewModel: ObservableObject {
    @Published var chessBoard = ChessBoard()
    @Published var moveHistory: MoveHistoryViewModel
    @Published var timerVM : TimerViewModel
    @Published var selectedPosition: Position?
    @Published var kingInCheckPosition: Position?
    @Published var currentPlayer: PlayerType = .white
    @Published var capturedPiecesWhite: [ChessPiece] = []
    @Published var capturedPiecesBlack: [ChessPiece] = []
    @Published var isCheckMated: Bool = false
    @Published var highlightValidMoves: [Position] = []
    
    var whiteKingPosition = Position(row: 7, column: 4)
    var blackKingPosition = Position(row: 0, column: 4)
    
    init(moveHistory: MoveHistoryViewModel, timerVM: TimerViewModel) {
        self.moveHistory = moveHistory
        self.timerVM = timerVM
        
        timerVM.startTimer()
    }

    /// Attempts to make a move from `from` position to `to` position.
    func makeMove(from: Position, to: Position) {
        guard let movingPiece = chessBoard.getPiece(at: from),
              isValidMove(from: from, to: to, movingPiece: movingPiece, board: chessBoard) else {
            return
        }

        // If in check, move must resolve the check
        if let _ = kingInCheckPosition,
           !doesResolveCheck(from: from, to: to, movingPiece: movingPiece, board: chessBoard, whiteKingPosition: whiteKingPosition, blackKingPosition: blackKingPosition) {
            return
        }
        
        processMove(from: from, to: to, movingPiece: movingPiece)
    }

    /// Processes a valid move.
    private func processMove(from: Position, to: Position, movingPiece: ChessPiece) {
        addCapturedPiece(at: to)
        updateKingPosition(movingPiece: movingPiece, to: to)

        _ = Move(movedPiece: movingPiece, capturedPiece: chessBoard.getPiece(at: to), from: from, to: to)
        
        moveHistory.saveToUndoStack(chessBoard: chessBoard)
        
        chessBoard.movePiece(from: from, to: to)
        
        if isCheckMate(chessBoard: chessBoard, attackingPlayer: currentPlayer, whiteKingPosition: whiteKingPosition, blackKingPosition: blackKingPosition) {
            isCheckMated = true
            print("checkmated")
        }

        // Update check status
        kingInCheckPosition = isKingInCheck(from: from, to: to, movingPiece: movingPiece, board: chessBoard, whiteKingPosition: whiteKingPosition, blackKingPosition: blackKingPosition)

        togglePlayerTurn()
        timerVM.switchTurn()
        timerVM.startTimer()
    }

    /// Updates the king’s position if moved.
    private func updateKingPosition(movingPiece: ChessPiece, to: Position) {
        if movingPiece.rank == .king {
            movingPiece.player == .white ? (whiteKingPosition = to) : (blackKingPosition = to)
        }
    }

    /// Toggles the current player’s turn.
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
                highlightValidMoves = []
            } else {
                selectedPosition = position
                highlightValidMoves = getAllValidMovesToHighlight(at: position,chessBoard: chessBoard,kingInCheckPosition: kingInCheckPosition,whiteKingPosition: whiteKingPosition,blackKingPosition: blackKingPosition)
            }
        } else {
            print("Invalid selection: It's not \(currentPlayer)'s turn.")
        }
    }

    /// Returns the chess piece at a given position.
    func getPiece(at position: Position) -> ChessPiece? {
        return chessBoard.getPiece(at: position)
    }

//    /// Returns a formatted move history.
//    func getMoveHistory() -> [String] {
//        return moveHistory.getAllMoves().map { $0.description() }
//    }

    /// Adds captured pieces to the corresponding list.
    private func addCapturedPiece(at position: Position) {
        guard let capturedPiece = chessBoard.getPiece(at: position) else { return }
        
        if capturedPiece.player == .white {
            capturedPiecesWhite.append(capturedPiece)
        } else {
            capturedPiecesBlack.append(capturedPiece)
        }
    }
}
