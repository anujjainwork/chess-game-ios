//
//  CapturedPiecesView.swift
//  ChessMate
//
//  Created by Anuj Jain on 15/02/25.
//

import SwiftUI

struct CapturedPiecesView: View {
    @EnvironmentObject var chessBoardViewModel: ChessBoardViewModel
    
    /// Indicates whether to show white's captured pieces (true) or black's (false).
    let whiteCapturedPieces: Bool
    
    /// Dimensions passed from the parent, used to size this view.
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        // Set a standard icon size for captured pieces
        let iconSize: CGFloat = 30
        
        // Group the captured pieces by type (imageName) and count them
        let groupedPieces = Dictionary(
            grouping: whiteCapturedPieces
                ? chessBoardViewModel.capturedPiecesWhite
                : chessBoardViewModel.capturedPiecesBlack
        ) { $0.imageName }
        .mapValues { $0.count }
        
        ZStack {
            // White translucent overlay, inset a bit so red peeks through
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.1))
                .padding(3)
            
            // HStack of the captured pieces
            HStack(spacing: 5) {
                ForEach(groupedPieces.keys.sorted(), id: \.self) { imageName in
                    ZStack {
                        // Each captured piece image
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                        
                        // Badge if more than one piece is captured
                        if let count = groupedPieces[imageName], count > 1 {
                            Text("\(count)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10) // Position top-right
                        }
                    }
                }
            }
            .padding(5)
        }
        .frame(width: width, height: height)
    }
}
