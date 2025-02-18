//
//  GameView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct FullBoardView: View {
    
    @State private var drawConfirmation = false
    @State private var resignConfirmation = false
    @State private var gameDrawn = false
    @State private var gameWonByWhite = false
    @State private var gameWonByBlack = false
    @EnvironmentObject var chessBoardVM : ChessBoardViewModel
    @EnvironmentObject var gameStatusVM : GameStatusViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let boardSize = min(geometry.size.width, geometry.size.height) * 0.9
            
            if gameDrawn {
                GameEndView(gameStatusVM: _gameStatusVM, isDraw: true, reason: "Game drawn")
            } else if gameWonByWhite {
                GameEndView(gameStatusVM: _gameStatusVM, isDraw: false, reason: "White won")
            } else if gameWonByBlack {
                GameEndView(gameStatusVM: _gameStatusVM, isDraw: false, reason: "Black won")
            } else {
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.greenA, Color.greenB]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        HStack{
                            DrawResignView(drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation)
                            MoveHistoryView(player: PlayerType.black)
                        }
                        .rotationEffect(Angle(degrees: 180))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 20)
                        
                        HStack(){
                            TimerView(isWhiteTimer: false)
                                .rotationEffect(Angle(degrees: 180))
                            Spacer()
                            CapturedPiecesView(whiteCapturedPieces: false, width: geometry.size.width * 0.65, height: max(40,60))
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal,20)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.greenC)
                            .frame(width: boardSize, height: boardSize * 1.02)
                            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 4)
                            .overlay(
                                ChessBoardView()
                                    .frame(width: boardSize * 0.96, height: boardSize * 0.99)
                                    .offset(x: -5, y: 10)
                            )
                        HStack (){
                            CapturedPiecesView(whiteCapturedPieces: true, width: geometry.size.width * 0.65, height: max(40,60))
                                .shadow(radius: 5)
                            Spacer()
                            TimerView(isWhiteTimer: true)
                        }
                        .padding(.horizontal, 20)
                        HStack {
                            DrawResignView(drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation)
                            MoveHistoryView(player: PlayerType.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                    if drawConfirmation {
                        var offeringPlayer = chessBoardVM.currentPlayer
                        var offeringPlayerIsWhite : Bool = chessBoardVM.currentPlayer == PlayerType.white
                        
                        if offeringPlayerIsWhite {
                            DrawResignConfirmation(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1, isDraw: true, isWhiteTurn: offeringPlayerIsWhite, currentPlayter: offeringPlayer,drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation, gameDrawn: $gameDrawn, gameWonByWhite: $gameWonByWhite, gameWonByBlack: $gameWonByBlack)
                                .rotationEffect(Angle(degrees: 180))
                        }
                        else {
                            DrawResignConfirmation(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1, isDraw: true, isWhiteTurn: offeringPlayerIsWhite, currentPlayter: offeringPlayer,drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation, gameDrawn: $gameDrawn, gameWonByWhite: $gameWonByWhite, gameWonByBlack: $gameWonByBlack)
                        }
                    }
                    
                    if resignConfirmation {
                        var offeringPlayer = chessBoardVM.currentPlayer
                        var offeringPlayerIsWhite : Bool = chessBoardVM.currentPlayer == PlayerType.white
                        
                        if offeringPlayerIsWhite {
                            DrawResignConfirmation(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1, isDraw: false, isWhiteTurn: offeringPlayerIsWhite, currentPlayter: offeringPlayer,drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation, gameDrawn: $gameDrawn, gameWonByWhite: $gameWonByWhite, gameWonByBlack: $gameWonByBlack)
                                .rotationEffect(Angle(degrees: 180))
                        }
                        else {
                            DrawResignConfirmation(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1, isDraw: false, isWhiteTurn: offeringPlayerIsWhite, currentPlayter: offeringPlayer,drawConfirmation: $drawConfirmation, resignConfirmation: $resignConfirmation, gameDrawn: $gameDrawn, gameWonByWhite: $gameWonByWhite, gameWonByBlack: $gameWonByBlack)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
    }
}
