//
//  TimeInterval.swift
//  ChessMate
//
//  Created by Anuj Jain on 17/02/25.
//

import Foundation

extension TimeInterval {
    var toTimerWidget : String {
        let minutes = Int(self)/60
        let seconds = Int(self)%60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
