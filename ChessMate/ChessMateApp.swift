//
//  ChessMateApp.swift
//  ChessMate
//
//  Created by Anuj Jain on 23/01/25.
//

import SwiftUI

@main
struct ChessMateApp: App {
    @StateObject var moveHistoryVM = MoveHistoryViewModel()
    @StateObject var chessBoardVM: ChessBoardViewModel

    init() {
        let moveHistory = MoveHistoryViewModel()
        let gameVM = ChessBoardViewModel(moveHistory: moveHistory)
        
        _moveHistoryVM = StateObject(wrappedValue: moveHistory)
        _chessBoardVM = StateObject(wrappedValue: gameVM)
    }

    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(moveHistoryVM)
                .environmentObject(chessBoardVM)
        }
    }
}
