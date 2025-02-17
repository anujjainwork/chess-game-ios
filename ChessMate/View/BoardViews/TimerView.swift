//
//  TimerView.swift
//  ChessMate
//
//  Created by Anuj Jain on 16/02/25.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var gameStatusVM: GameStatusViewModel
    @EnvironmentObject private var timerVM: TimerViewModel
    var isWhiteTimer : Bool

    var body: some View {
        Text(isWhiteTimer ? "\(timerVM.whiteTimeRemaining.toTimerWidget)" : "\(timerVM.blackTimeRemaining.toTimerWidget)")
            .foregroundStyle(Color.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.20), location: 0),
                                .init(color: Color.white.opacity(0.08), location: 0.5),
                                .init(color: Color.white.opacity(0.10), location: 1)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
    }
}
