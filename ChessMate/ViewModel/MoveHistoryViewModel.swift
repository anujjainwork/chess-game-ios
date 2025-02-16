//
//  MoveHistory.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

class MoveHistoryViewModel: ObservableObject {
    @Published var undoEnabled: Bool = false
    @Published var redoEnabled: Bool = false
    @Published var backToMainGame: Bool = true
    @Published var currentBoard: ChessBoard = ChessBoard()
    
    private var undoStack: [ChessBoard] = []
    private var redoStack: [ChessBoard] = []

    init() {
        currentBoard.initialiseBoard()
        undoStack.append(currentBoard.copy())
        updateButtons()
    }

    func saveToUndoStack(chessBoard: ChessBoard) {
        undoStack.append(chessBoard.copy())
        redoStack.removeAll()
        updateButtons()
    }

    private func saveToRedoStack() {
        redoStack.append(currentBoard.copy())
        updateButtons()
    }

    func undoMove() {
        guard undoStack.count > 1 else { return }

        saveToRedoStack()
        currentBoard = undoStack.removeLast()
        updateButtons()
    }

    func redoMove() {
        guard let nextBoard = redoStack.popLast() else { return }

        undoStack.append(currentBoard.copy())
        currentBoard = nextBoard
        updateButtons()
    }

    private func updateButtons() {
        undoEnabled = undoStack.count > 1 // Prevent undo if only the initial board remains
        redoEnabled = !redoStack.isEmpty
        backToMainGame = redoStack.isEmpty
    }
}
