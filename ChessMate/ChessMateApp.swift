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
    @StateObject var gameStatusVM = GameStatusViewModel()
    @StateObject var timerVM: TimerViewModel

    init() {
        let moveHistory = MoveHistoryViewModel()
        let gameStatusVM = GameStatusViewModel()
        let timerVM = TimerViewModel(gameStatusVM: gameStatusVM)
        let chessBoardVM = ChessBoardViewModel(moveHistory: moveHistory,timerVM: timerVM)
        
        _moveHistoryVM = StateObject(wrappedValue: moveHistory)
        _chessBoardVM = StateObject(wrappedValue: chessBoardVM)
        _gameStatusVM = StateObject(wrappedValue: gameStatusVM)
        _timerVM = StateObject(wrappedValue: timerVM)
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(gameStatusVM)
                .environmentObject(timerVM)
                .environmentObject(moveHistoryVM)
                .environmentObject(chessBoardVM)
        }
    }
}
