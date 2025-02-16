//
//  CapturedPiecesView.swift
//  ChessMate
//
//  Created by Anuj Jain on 15/02/25.
//

import SwiftUI

struct CapturedPiecesView: View {
    @EnvironmentObject var chessBoardViewModel: ChessBoardViewModel
    var whiteCapturedPieces: Bool

    var body: some View {
        GeometryReader { geometry in
            let iconSize: CGFloat = 30

            // Group the captured pieces by type and count them
            let groupedPieces = Dictionary(grouping: whiteCapturedPieces
                                           ? chessBoardViewModel.capturedPiecesWhite
                                           : chessBoardViewModel.capturedPiecesBlack) { $0.imageName }
                .mapValues { $0.count }

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.1))
                    .blur(radius: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .frame(width: geometry.size.width * 0.85, height: max(iconSize + 12, 60))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                HStack(spacing: 8) {
                    ForEach(groupedPieces.keys.sorted(), id: \.self) { imageName in
                        ZStack {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .padding(6)

                            // Show count badge if more than 1 piece exists
                            if let count = groupedPieces[imageName], count > 1 {
                                Text("\(count)")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 18, height: 18)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -10) // Position at top-right
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CapturedPiecesView(chessBoardViewModel: ChessBoardViewModel(moveHistory: ), whiteCapturedPieces: false)
//}
