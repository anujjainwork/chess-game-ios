//
//  GameStatusViewModel.swift
//  ChessMate
//
//  Created by Anuj Jain on 16/02/25.
//

import Foundation

class GameStatusViewModel : ObservableObject {
    @Published var gameStatus : GameStatus = GameStatus.initial
    
    func chooseGameMode(choosedGameMode: GameMode) {
        gameStatus = GameStatus.playing(gameMode: choosedGameMode)
    }
    
    func updateGameStatusToWin(winner: PlayerType) {
        let newGameStatus = GameStatus.win(whoWon: winner)
        gameStatus = newGameStatus
    }
    
    func updateGameStatusToDraw(){
        let newGameStatus = GameStatus.draw
        gameStatus = newGameStatus
    }
}
