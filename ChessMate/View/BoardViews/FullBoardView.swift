//
//  GameView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct FullBoardView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let boardSize = min(geometry.size.width, geometry.size.height) * 0.9
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.greenA, Color.greenB]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    MoveHistoryView(player: PlayerType.black)
                        .rotationEffect(Angle(degrees: 180))
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
                    MoveHistoryView(player: PlayerType.white)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

//// MARK: - Preview
//#Preview {
//    FullBoardView()
//}
