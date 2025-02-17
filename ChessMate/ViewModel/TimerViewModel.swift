//
//  TimerViewModel.swift
//  ChessMate
//
//  Created by Anuj Jain on 16/02/25.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var whiteTimeRemaining: TimeInterval
    @Published var blackTimeRemaining: TimeInterval
    @Published var isWhiteTurn: Bool = true

    private var timer: Timer?
    private var gameStatusVM: GameStatusViewModel
    
    init(gameStatusVM: GameStatusViewModel) {
        self.gameStatusVM = gameStatusVM

        // Set the timer values
        self.whiteTimeRemaining = TimeInterval(10 * 60)
        self.blackTimeRemaining = TimeInterval(10 * 60)
    }

    func startTimer() {
        timer?.invalidate()
        
        guard case .playing = gameStatusVM.gameStatus else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.isWhiteTurn {
                self.whiteTimeRemaining = max(self.whiteTimeRemaining - 1, 0)
            } else {
                self.blackTimeRemaining = max(self.blackTimeRemaining - 1, 0)
            }
            
            if self.whiteTimeRemaining == 0 {
                self.gameStatusVM.updateGameStatusToWin(winner: .black)
                self.stopTimer()
            } else if self.blackTimeRemaining == 0 {
                self.gameStatusVM.updateGameStatusToWin(winner: .white)
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func switchTurn() {
        isWhiteTurn.toggle()
    }
    
    func resetTimer() {
        stopTimer()
        self.whiteTimeRemaining = TimeInterval(10 * 60)
        self.blackTimeRemaining = TimeInterval(10 * 60)
    }
}
