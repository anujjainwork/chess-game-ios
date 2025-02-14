//
//  ChessMateApp.swift
//  ChessMate
//
//  Created by Anuj Jain on 23/01/25.
//

import SwiftUI

@main
struct ChessMateApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(gameViewModel: ChessBoardViewModel())
        }
    }
}
